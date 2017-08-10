class FiguresController < ApplicationController

  get '/figures/new' do
    erb :'figures/new'
  end

  post '/figures' do
    #binding.pry
    @figure = Figure.new(params[:figure])

    @title = Title.new(params[:title])
    @title.save
    @figure.titles << @title

    @landmark = Landmark.new(params[:landmark])
    @landmark.save
    @figure.landmarks << @landmark

    @figure.save
    redirect :'figures/index'
  end

  get '/figures/:id/edit' do
    @figure = Figure.find_by(params[:id])

    erb :'/figures/edit'
  end

  patch '/figures/:id' do
    @figure = Figure.find_by(params[:id])
    @title = Title.find_or_create_by(name: params[:figure][:title_ids])
    @figure.titles << @title
    @landmark = Landmark.find_or_create_by(name: params[:figure][:landmark_ids])
    @figure.landmarks << @landmark
    @figure.name = params[:figure][:name]
    @figure.save
    #binding.pry

    redirect :"/figures/#{@figure.id}"
  end

  get '/figures/:id' do
    #binding.pry
    @figure = Figure.find_by(params[:id])
    erb :'/figures/show'
  end

  get '/figures' do
    erb :'figures/index'
  end

end
