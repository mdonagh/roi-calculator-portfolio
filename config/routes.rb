Rails.application.routes.draw do
  root to: 'rois#index'
  post '/rois' => 'rois#create'
  put '/rois' => 'rois#schedule_meeting', as: 'schedule_meeting'
  get '/rois/:uuid' => 'rois#show'
  get '/rois/:uuid/pdf_ready' => 'rois#pdf_ready'
end
