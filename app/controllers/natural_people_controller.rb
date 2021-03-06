# frozen_string_literal: true

class NaturalPeopleController < AuthenticatedController
  before_action :set_natural_person, only: %i[show edit update destroy]

  # GET /natural_people
  # GET /natural_people.json
  def index
    @natural_people = NaturalPerson.all
  end

  # GET /natural_people/1
  # GET /natural_people/1.json
  def show
  end

  # GET /natural_people/new
  def new
    @natural_person = NaturalPerson.new
  end

  # GET /natural_people/1/edit
  def edit
  end

  # POST /natural_people
  # POST /natural_people.json
  def create
    @natural_person = NaturalPerson.new(natural_person_params)
    respond_to do |format|
      var = @natural_person
      if @natural_person.save
        msg = 'Natural person was successfully created.'
        format.html { redirect_to(var, notice: msg) }
        format.json { render(:show, status: :created, location: var) }
      else
        format.html { render(:new) }
        format.json { render(json: var.errors, status: :unprocessable_entity) }
      end
    end
  end

  # PATCH/PUT /natural_people/1
  # PATCH/PUT /natural_people/1.json
  def update
    respond_to do |format|
      if @natural_person.update(natural_person_params)
        msg = 'Natural person was successfully updated.'
        format.html { redirect_to(@natural_person, notice: msg) }
        format.json { render(:show, status: :ok, location: @natural_person) }
      else
        format.html { render(:edit) }
        format.json do
          render(json: @natural_person.errors,
                 status: :unprocessable_entity)
        end
      end
    end
  end

  # DELETE /natural_people/1
  # DELETE /natural_people/1.json
  def destroy
    @natural_person.destroy
    respond_to do |format|
      msg = 'Natural person was successfully destroyed.'
      format.html { redirect_to(natural_people_url, notice: msg) }
      format.json { head(:no_content) }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_natural_person
    @natural_person = NaturalPerson.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def natural_person_params
    params.require(:natural_person).permit(:nombre, :apellido, :related_account)
  end
end
