#This program is dedicated to Tom, a friend of a friend,
#but whose legacy will live on.

#this file holds the main function of the course-grabbing program.

require './User'
require 'selenium-webdriver'

def main_course() 
	
	user = User.make_user()
	user.set_courses(Course.make_courses())

	puts "Courses:\n-----"
	user.desired_courses.each do |c|
		puts c.to_string()
	end

	#selenium web driver
	driver = get_driver_firefox
	get_website(driver) 
	select_semester(driver)
	log_in(driver, user)

	#this method will sign up to the desired courses for the user
	user.assign_courses(driver)

	driver.quit
end

def visit_course(driver, course)

	#driver.find_element(:link, "Search All Courses").click

	courseSearch = driver.find_element(:link, "Search for Courses that Meet My Schedule");
	courseSearch.click;

	#there are multiple "MDASKEYY" fields. Get the one from the right div
	courseCodeBox = driver.find_element(:id, "search_mts")
	courseCodeField = courseCodeBox.find_element(:name, "MDASKEYY")

	courseCodeField.send_keys(course.code)

	#apparently there are also multiple "search_mts" divs. lol.
	#this selects the second 'Search' button, which happens to be the one we want
	searchButton = driver.find_elements(:xpath, "//input[@value='Search']")[1]
	searchButton.click;

	table = driver.find_elements(:xpath, "//table")[0]; #first table
	tableRows = table.find_elements(:tag_name, "tr"); #get the rows

	courseRow = tableRows[1]
	if (courseRow.find_elements(:tag_name, "td")[0].text.include? "There are NO MORE sections of this course")
		backButton = driver.find_element(:xpath, "//input[@value='Back to Registration']")
		backButton.click
		return false
	else
		submitButton = courseRow.find_element(:xpath, "//input[@type='SUBMIT']")
		submitButton.click

		yesButton = driver.find_element(:xpath, "//input[@value='Yes']")
		return true
	end
end

def visit_specific_course(driver, course)
	#TODO
	return true #if course added
end

def log_in(driver, user)	
	#now for actually logging in...
	usernameField = driver.find_element(:id, "username")
	usernameField.send_keys(user.name)

	passwordField = driver.find_element(:id, "password")
	passwordField.send_keys(user.password)

	loginButton = driver.find_element(:name, "login")
	loginButton.click
end 

def get_driver_firefox()
	driver = Selenium::WebDriver.for(:firefox) 
end

def get_website(driver)
	driver.get "http://isis.ufl.edu"
end 

def select_semester(driver)
	begin #open up the pull down menu in case we need to
		springButton = driver.find_element(:link, "- Spring")
		springButton.click

	rescue Selenium::WebDriver::Error::NoSuchElementError
		registrationButton = driver.find_element(:link, "Registration")
		registrationButton.click

		springButton = driver.find_element(:link, "- Spring")
		springButton.click
	end
end

main_course()

=begin
def get_courses(driver)
	courseSearch = driver.find_element(:link, "Search All Courses")
	courseSearch.click

	courseCodeField = driver.find_element(:name, "REGCSE") #thats the name of the input field...
	courseCodeField.send_keys(course.code)

	searchButton = driver.find_element(:xpath, "//input[@value='Search']") #find the search button
	searchButton.click

	#the resultant table in the following page
	table = driver.find_elements(:xpath, "//table")[0] #first table in the page is the one we want
	tableRows = table.find_elements(:tag_name, "tr") #get the rows
	acceptable_courses = [] #initialize array for the rows matching the desired course
	

	tableRows[1..-1].each do |row| #the 0th row is a header row and we do not want it
		if (course.check_match(row))
			acceptable_courses << row 
			#do we want an array of acceptable courses, or do we want to just go ahead and select the course when it comes up?
		end
	end 

	acceptable_courses.each do |c|
		puts c[0].text
	end

	backButton = driver.find_element(:xpath, "//input[@value='Back to Registration']")
	backButton.click
	return acceptable_courses
end 
=end
