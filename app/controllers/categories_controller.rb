# frozen_string_literal: true

class CategoriesController < AuthenticatedController
  before_action :set_category, only: %i[show edit update destroy]

  # GET /categories
  # GET /categories.json
  def index
    @categories = Category.all
  end

  # GET /categories/1
  # GET /categories/1.json
  def show
  end

  # GET /categories/new
  def new
    @category = Category.new
  end

  # GET /categories/1/edit
  def edit
  end

  # POST /categories
  # POST /categories.json
  def create
    @category = Category.new(category_params)

    respond_to do |format|
      if @category.save
        msg = 'Category was successfully created.'
        format.html { redirect_to(@category, notice: msg) }
        format.json { render(:show, status: :created, location: @category) }
      else
        format.html { render(:new) }
        format.json do
          render(json: @category.errors,
                 status: :unprocessable_entity)
        end
      end
    end
  end

  # PATCH/PUT /categories/1
  # PATCH/PUT /categories/1.json
  def update
    respond_to do |format|
      if @category.update(category_params)
        msg = 'Category was successfully updated.'
        format.html { redirect_to(@category, notice: msg) }
        format.json { render(:show, status: :ok, location: @category) }
      else
        format.html { render(:edit) }
        format.json do
          render(json: @category.errors,
                 status: :unprocessable_entity)
        end
      end
    end
  end

  # DELETE /categories/1
  # DELETE /categories/1.json
  def destroy
    @category.destroy
    respond_to do |format|
      msg = 'Category was successfully destroyed.'
      format.html { redirect_to(categories_url, notice: msg) }
      format.json { head(:no_content) }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_category
    @category = Category.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def category_params
    params.require(:category).permit(:name, :description)
  end
end
