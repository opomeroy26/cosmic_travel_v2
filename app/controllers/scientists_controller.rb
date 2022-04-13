class ScientistsController < ApplicationController

    def index 
        scientists = Scientist.all 
        render json: scientists 
    rescue ActiveRecord::RecordNotFound => invalid 
        render json: {errors: invalid.model}, status: :not_found 
    end

    def show 
        scientist = Scientist.find(params[:id])
        render json: scientist, serializer: ScientistWithPlanetsSerializerSerializer  #custom serializer to show planets 
    rescue ActiveRecord::RecordNotFound => invalid 
        render json: {error: "Scientist not found"}, status: :not_found
    end
    
    def create 
        scientist = Scientist.create!(scientist_params)
        render json: scientist, status: :created 
    rescue ActiveRecord::RecordInvalid => invalid 
        render json: {errors: invalid.record.errors.full_messages}, status: :unprocessable_entity
    end

    def update 
        scientist = Scientist.find(params[:id])
        scientist.update!(scientist_params)
        render json: scientist, status: :accepted 
    rescue ActiveRecord::RecordInvalid => invalid 
        render json: {errors: invalid.record.errors.full_messages}, status: :unprocessable_entity

    end

    def destroy
        scientist = Scientist.find(params[:id])
        scientist.destroy! 
        head :no_content
    rescue ActiveRecord::RecordNotFound => invalid 
        render json: {error: "#{invalid.model} not found"}, status: :not_found

    end

    private 

    def scientist_params 
        params.permit(:name, :field_of_study, :avatar)
    end
end
