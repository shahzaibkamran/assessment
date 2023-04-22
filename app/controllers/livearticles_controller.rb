class LivearticlesController < ApplicationController
   
    def search
        @results = Article.search(params[:search])
        render json: @results, status: :ok
    end

    private 

    def livearticle_params
        params.require(:article).permit(:search)
    end
end