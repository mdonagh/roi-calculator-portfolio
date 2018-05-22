class UserMailer < ApplicationMailer
	default from: 'info@infomill.com'
	
	def send_report_email(roi,pdf)
		@roi = roi
		attachments['ROI Report.pdf'] = pdf.to_pdf
		mail(to: @roi.email, subject: 'Your AnswersAnywhere ROI Report')
	end
end
