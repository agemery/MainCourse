#This program is dedicated to Tom, a friend of a friend,
#but whose legacy will live on.

#this file holds the main function of the course-grabbing program.

require './Course.rb'
require 'selenium-webdriver'


def main_course(username, password) 
	#pls pass the parameters
	#maybe I will add a prompt in case they are null

	#this might change to be a parameter idk
	courses = [(Course.new("EEL474")), (Course.new("CIS4930"))]

	#selenium web driver
	driver = Selenium::WebDriver.for(:firefox) 
	#this is the website the program is designed for
	driver.get "http://isis.ufl.edu"
	valid_courses =[] 

	log_in(driver, username, password)
	courses.each do |c|
		valid_courses << get_courses(driver, c)
	end

	puts valid_courses
end

def log_in(driver, username, password)

	begin #open up the pull down menu in case we need to
		springButton = driver.find_element(:link, "- Spring")
		springButton.click

	rescue Selenium::WebDriver::Error::NoSuchElementError
		registrationButton = driver.find_element(:link, "Registration")
		registrationButton.click

		springButton = driver.find_element(:link, "- Spring")
		springButton.click
	end

	#now for actually logging in...
	usernameField = driver.find_element(:id, "username")
	usernameField.send_keys(username)

	passwordField = driver.find_element(:id, "password")
	passwordField.send_keys(password)

	loginButton = driver.find_element(:name, "login")
	loginButton.click
end 

def get_courses(driver, course)
	courseSearch = driver.find_element(:link, "Search All Courses");
	courseSearch.click;

	courseCodeField = driver.find_element(:name, "REGCSE"); #thats the name of the input field...
	courseCodeField.send_keys(course.code);

	searchButton = driver.find_element(:xpath, "//input[@value='Search']"); #find the search button
	searchButton.click;

	#the resultant table in the following page
	table = driver.find_elements(:xpath, "//table")[0]; #first table in the page is the one we want
	tableRows = table.find_elements(:tag_name, "tr"); #get the rows
	acceptable_courses = [] #initialize array for the rows matching the desired course
	

	tableRows[1..-1].each do |row| #the 0th row is a header row and we do not want it
		if (course.check_match(row))
			acceptable_courses << row 
			#do we want an array of acceptable courses, or do we want to just go ahead and select the course when it comes up?
		end
	end 
	return acceptable_courses
end 

puts "Enter the username"
username = gets.chomp
puts "Enter the password lol"
password = gets.chomp

main_course(username, password)
