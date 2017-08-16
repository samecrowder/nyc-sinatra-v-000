class LandmarksController < ApplicationController

  get '/landmarks/new' do
    erb :'/landmarks/new'
  end

  post '/landmarks/new' do
    @landmark = Landmark.new(name: params[:landmark][:name], year_completed: params[:landmark][:year_completed])
    @landmark.save
  end

  get '/landmarks/:id' do
    @landmark = Landmark.find(params[:id])
    erb :'/landmarks/show'
  end

  get '/landmarks' do
    erb :'/landmarks/index'
  end

  get '/landmarks/:id/edit' do
    @landmark = Landmark.find(params[:id])
    erb :'/landmarks/edit'
  end

  patch '/landmarks/:id/edit' do
    @landmark = Landmark.find(params[:id])

    if params[:landmark][:name] != ""
      @landmark.name = params[:landmark][:name]
    end

    if params[:landmark][:year_completed] != ""
      @landmark.year_completed = params[:landmark][:year_completed].to_i
    end
    @landmark.save

    redirect to "/landmarks/#{@landmark.id}"
  end
end
