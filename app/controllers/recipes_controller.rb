class RecipesController < ApplicationController
	before_action :find_recipe, only: [:show, :edit, :update, :destroy]
	def index
		@recipe = Recipe.all.order("created_at DESC")
	end

	def show
	end

	def new
		@recipe = Recipe.new
		@recipe.ingredients.build
	end

	def create
		@recipe = Recipe.new(recipe_params)
		@recipe.ingredients.build
		if @recipe.save
			redirect_to @recipe, notice: "Successfuly created new recipe"
		else
			render 'new'
		end
	end

	def edit
	end

	def update
		if @recipe.update(recipe_params)
			redirect_to @recipe
		else
			render 'edit'
		end
	end

	def destroy
		@recipe.destroy
			redirect_to root_path, notice: "Sucessfully deleted recipe"
	end

	private

	def recipe_params

		# ingredients=params[:recipe][:ingredients_attributes]
		# x=ingredients.values
		# params[:recipe][:ingredients_attributes]=x
		# puts x

		params.require(:recipe)
			.permit(
				:title,
				:description,
				:image,
				ingredients_attributes: [:id, :name, :_destroy],
				directions_attributes: [:id, :step, :_destroy]
			)
	end
	
	def find_recipe
		@recipe = Recipe.find(params[:id])
	end
end
