class MoviesController < ApplicationController
    skip_before_action :require_user, only: [:index, :show]
    def index
        @movies = Movie.order(:title)
    end
    
    def show
        id = params[:id]
        @movie = Movie.find(id)
    end
    
    def new
        @movie = Movie.new
    end
    
    def create
        @movie = Movie.create!(movie_params)
        flash[:notice] = "#{@movie.title} was successfully created."
        redirect_to movie_path(@movie)
    end
    
    def edit
        @movie = Movie.find(params[:id])
    end
    
    def update
        @movie = Movie.find(params[:id])
        @movie.update_attributes!(movie_params)
        flash[:notice] = "#{@movie.title} was successfully updated."
        redirect_to movie_path(@movie)
    end

    def destroy
        @movie = Movie.find(params[:id])
        @movie.destroy
        flash[:notice] = "Movie '#{@movie.title}' deleted."
        redirect_to movies_path
    end
    
    def search_tmdb
        if params[:search_terms] != ""
            @movies = Tmdb::Movie.find(params[:search_terms])
        else
            flash[:warning] = "Can't search with empty"
            redirect_to movies_path
        end
    end
    
    def add_tmdb
        if params[:id] != nil
            @movie = Tmdb::Movie.detail(params[:id])
            Movie.create!(:title => @movie["title"], :rating => @movie["vote_average"],:description => @movie["overview"], :release_date => @movie["release_date"])
            redirect_to movies_path
        end
    end
    
    private
    def movie_params
        params.require(:movie).permit(:title, :rating, :description, :release_date)
    end
end
