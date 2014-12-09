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

	#log_out(driver)
	#driver.quit
end

def visit_course(driver, course)
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
		puts "#{course.code} added? FALSE"
		return false
	else
		submitButton = courseRow.find_element(:xpath, "//input[@type='SUBMIT']")
		submitButton.click

		yesButton = driver.find_element(:xpath, "//input[@value='Yes']")
		yesButton.click
		puts "#{course.code} added? TRUE"
		return true
	end
end

def visit_specific_course(driver, section_number)
	courseSearch = driver.find_element(:link, "Add a Section");
	courseSearch.click;

	#there are multiple "COMASECT" fields. Get the one from the right div)
	courseSectionBox = driver.find_element(:id, "search_exp")
	courseSectionField = courseSectionBox.find_element(:name, "COMASECT")
	courseSectionField.send_keys(section_number)

	addButton = driver.find_element(:xpath, "//input[@value='Add this course']")
	addButton.click;

	#always click 'Yes'
	yesButton = driver.find_element(:xpath, "//input[@value='Yes']")
	yesButton.click

	#if "reg_good" exists then we have successfully added the course
	if (driver.find_elements(:id, "reg_good").size > 0)
		puts "#{section_number} added? TRUE"
		return true
	else
		puts "#{section_number} added? FALSE"
		return false
	end
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
