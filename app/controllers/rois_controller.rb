class RoisController < ApplicationController
  skip_before_action :verify_authenticity_token

  after_action :allow_iframe

  def index
    @roi = Roi.new
  end

  def create
    @roi = Roi.new(roi_params)

    respond_to do |format|
      if @roi.save
        format.json { render json: @roi, status: 200  }
      else
        format.json { render json: @roi.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
    @roi = Roi.find_by(uuid: params[:uuid])
    @roi.update_columns(pdf_ready: false)
    roi_report = WickedPdf.new.pdf_from_string(
      render_to_string('rois/show.html.erb'),
            page_size: "Letter",
            margin: {bottom: 20},
            javascript_delay: 500,
            disposition: 'attachment',
            header: { content: render_to_string('rois/header.html.erb')},
    )
    pdf = CombinePDF.new
    pdf << CombinePDF.load(Rails.root.join('public', 'cover_page.pdf'))
    pdf << CombinePDF.parse(roi_report)
    #pdf << CombinePDF.load(Rails.root.join('public', 'summary.pdf'))
    send_data pdf.to_pdf, filename: "Roi-Report.pdf", type: "application/pdf"
    @roi.update_columns(pdf_ready: true)
    #begin
      UserMailer.send_report_email(@roi, pdf).deliver
    #rescue => e
    #end
  end

  def pdf_ready
    @roi = Roi.find_by(uuid: params[:uuid])
    render json: @roi.pdf_ready
  end
  
  def schedule_meeting
    @roi = Roi.find(params[:roi][:id])
    @roi.update_columns(meeting_requested: true)
    @roi.update_attributes(roi_params)
  end

  private
  
    def allow_iframe
      response.headers.delete 'X-Frame-Options'
    end

    def roi_params
      params.require(:roi).permit(:id,
                                  :name,
                                  :email,
                                  :telephone,
                                  :company,
                                  :priority,
                                  :product_types,
                                  :field_technicians,
                                  :visits_per_day_per_technician)
    end
end
