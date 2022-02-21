require 'json'
class BuildingsController < ApplicationController
  # array로 주되 compact 사용
  def oneone
    @meals=Meal.all
    @meals=@meals.where(:id => 1..21)
    @meals.each do |meal|
      meal.menu=meal.menu.split("\n")
    end
    puts Time.zone.now
      render json:@meals
  end
  
  def onetwo
    @meals=Meal.all
    # @meals=@meals.where(:id => 22..26)
    @meals=@meals.find(3)
    # @meals.each do |meal|
    #   meal.menu=meal.menu.split("\n")
    # end
    puts Time.zone.now.strftime("%A")
    test_json = {:version => "2.0", :template => {:outputs => [:simpleText =>{:text => @meals.menu}]}}
    render json:test_json
  end
  
  def twoone
    @meals=Meal.all
    @meals=@meals.where(:id => 27..41)
    @meals.each do |meal|
      meal.menu=meal.menu.split("\n")
    end
    render json:@meals
  end
end
