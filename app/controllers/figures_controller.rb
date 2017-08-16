class FiguresController < ApplicationController

  get '/figures' do
    erb :'/figures/index'
  end

  get '/figures/new' do
    erb :'/figures/new'
  end

  post '/figures/new' do
    @figure = Figure.new(name: params[:figure][:name])

    if params[:figure][:title_ids] != nil
      params[:figure][:title_ids].each do |title_id|
        @figure.titles << Title.find(title_id)
      end
    end

    if params[:figure][:title] != ""
      @title = Title.new(name: params[:figure][:title])
      @figure.titles << @title
    end

    if params[:figure][:landmark_ids] != nil
      params[:figure][:landmark_ids].each do |landmark_id|
        @figure.landmarks << Landmark.find(landmark_id)
      end
    end

    if params[:figure][:landmark] != ""
      @landmark = Landmark.new(name: params[:figure][:landmark])
      @figure.landmarks << @landmark
    end

    @figure.save
  end

  get '/figures/:id' do
    @figure = Figure.find(params[:id])
    erb :'/figures/show'
  end

  get '/figures/:id/edit' do
    @figure = Figure.find(params[:id])
    erb :'/figures/edit'
  end

  patch '/figures/:id/edit' do
    @figure = Figure.find(params[:id])

    if params[:figure][:name] != ""
      @figure.name = params[:figure][:name]
    end

    @figure.titles.clear
    if params[:figure][:title_ids] != nil
      params[:figure][:title_ids].each do |title_id|
        @figure.titles << Title.find(title_id)
      end
    end

    if params[:figure][:title] != ""
      @title = Title.new(name: params[:figure][:title])
      @figure.titles << @title
    end

    @figure.landmarks.clear
    if params[:figure][:landmark_ids] != nil
      params[:figure][:landmark_ids].each do |landmark_id|
        @figure.landmarks << Landmark.find(landmark_id)
      end
    end

    if params[:figure][:landmark] != ""
      @landmark = Landmark.new(name: params[:figure][:landmark])
      @figure.landmarks << @landmark
    end

    @figure.save
    redirect to "/figures/#{params[:id]}"
  end
end