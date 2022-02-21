class MealsController < ApplicationController
  before_action :set_meal, only: [:show, :update, :delete]

  # GET /meals
  def index
    @meals = Meal.all
    render json: @meals
  end

  # GET /meals/1
  def show
    render json: @meal
  end

  # POST /meals
  def create
    @meal = Meal.new(meal_params)

    if @meal.save
      render json: @meal, status: :created
    else
      render json: @meal.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /meals/1
  def update
    if @meal.update(meal_params)
      render json: @meal
    else
      render json: @meal.errors, status: :unprocessable_entity
    end
  end

  # DELETE /meals/1
  def delete
    @meal.destroy
    render json: {deleted: true}
  end
  
  # POST /meals/next/kor
  def show_next_kor
    @meals = Meal.where(:meal_date => Time.zone.now.strftime("%Y-%m-%d"))
    operationTime = "08:00~09:00"
    test_json = {:version => "2.0", :template => {:outputs => [:simpleText =>{:text => "아직 제공받지 못한 날짜의 식단입니다."}]}}
    if @meals.length != 0
      if (Time.zone.now.strftime("%H").to_i >= 0 && Time.zone.now.strftime("%H").to_i < 9 )
        @meals = @meals.where(:kind_of_meal => "조식")
      elsif (Time.zone.now.strftime("%H").to_i >= 9 && Time.zone.now.strftime("%H").to_i < 13 )
        @meals = @meals.where(:kind_of_meal => "중식")
        operationTime = "11:30~13:30"
      elsif (Time.zone.now.strftime("%H").to_i >= 13 && Time.zone.now.strftime("%H").to_i < 19)
        @meals = @meals.where(:kind_of_meal => "석식")
        operationTime = "17:00~19:00"
      elsif (Time.zone.now.strftime("%H").to_i >= 19 && Time.zone.now.strftime("%H").to_i <= 23 )
        @meals = Meal.where(:meal_date => Time.zone.now.next_day(1).strftime("%Y-%m-%d"))
        @meals = @meals.where(:kind_of_meal => "조식")
      end
      information = @meals[0].meal_date + " " + @meals[0].kind_of_meal + "\n" + operationTime + "\n\n" 
       @meals.each do |meal|
        information += meal.title + "\n" + meal.menu + "\n"
      end
      test_json = {:version => "2.0", :template => {:outputs => [:simpleText =>{:text => information}]}}
    end
    render json:test_json
  end
  
  # POST /meals/next/eng
  def show_next_eng
    @meals = Meal.where(:meal_date => Time.zone.now.strftime("%Y-%m-%d"))
    operationTime = "08:00~09:00"
    test_json = {:version => "2.0", :template => {:outputs => [:simpleText =>{:text => "Not serviced"}]}}
    if @meals.length != 0
      if (Time.zone.now.strftime("%H").to_i >= 0 && Time.zone.now.strftime("%H").to_i < 9 )
        @meals = @meals.where(:kind_of_meal => "Breakfast")
      elsif (Time.zone.now.strftime("%H").to_i >= 9 && Time.zone.now.strftime("%H").to_i < 13 )
        @meals = @meals.where(:kind_of_meal => "Lunch")
        operationTime = "11:30~13:30"
      elsif (Time.zone.now.strftime("%H").to_i >= 13 && Time.zone.now.strftime("%H").to_i < 19)
        @meals = @meals.where(:kind_of_meal => "Dinner")
        operationTime = "17:00~19:00"
      elsif (Time.zone.now.strftime("%H").to_i >= 19 && Time.zone.now.strftime("%H").to_i <= 23 )
        @meals = Meal.where(:meal_date => Time.zone.now.next_day(1).strftime("%Y-%m-%d"))
        @meals = @meals.where(:kind_of_meal => "Breakfast")
      end
      information = @meals[0].meal_date + " " + @meals[0].kind_of_meal + "\n" + operationTime + "\n\n" 
       @meals.each do |meal|
        information += meal.title + "\n" + meal.menu + "\n"
      end
      test_json = {:version => "2.0", :template => {:outputs => [:simpleText =>{:text => information}]}}
    end
    render json:test_json
  end
  
  # POST /meals/specific
  def show_specific
    @meals = Meal.all
    if params["action"]["params"]["sys_date"].present?
      sys_date = JSON.parse(params["action"]["params"]["sys_date"])["date"]
      @meals = @meals.where(:meal_date => sys_date)
    else
      @meals = @meals.where(:meal_date => Time.zone.now.strftime("%Y-%m-%d"))
    end
    if params["action"]["params"]["식단"].present?
      @meals = @meals.where(:kind_of_meal => params["action"]["params"]["식단"])
    end
    unless @meals.present?
      test_json = {:version => "2.0", :template => {:outputs => [:simpleText =>{:text => "아직 제공받지 못한 날짜의 식단입니다."}]}}
    else
      menus = ""
      @meals.each do |meal|
        menus += meal.title + " " + meal.kind_of_meal + "\n\n" + meal.menu + "\n"
      end
      test_json = {:version => "2.0", :template => {:outputs => [:simpleText =>{:text => @meals[0].meal_date + "\n\n" + menus}]}}
    end
    render json:test_json
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_meal
      @meal = Meal.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def meal_params
      params.require(:meal).permit(:title, :menu, :meal_date, :kind_of_meal)
    end
end
