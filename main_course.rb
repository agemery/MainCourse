#This program is dedicated to Tom, a friend of a friend,
#but whose legacy will live on.

#this file holds the main function of the course-grabbing program.

def main_course(username, password) 
	#pls pass the parameters
	#maybe I will add a prompt in case they are null

	#this might change to be a parameter idk
	courses = ["EEL4744", "EES"]

	#selenium web driver
	driver = Selenium::WebDriver.for(:firefox) 
	#this is the website the program is designed for
	driver.get "http://isis.ufl.edu" 

	log_in(driver, username, password)
	courses.each do |c|
		course_search(driver, c)
	end
end

def log_in(driver, username, password)

	begin #open up the pull down menu in case we need to
		SpringButton = driver.find_element(:link, "- Spring")
		SpringButton.click

	rescue Selenium::WebDriver::Error::NoSuchElementError
		RegistrationButton = driver.find_element(:link, "Registration")
		RegistrationButton.click

		SpringButton = driver.find_element(:link, "- Spring")
		SpringButton.click
	end

	#now for actually logging in...
	UsernameField = driver.find_element(:id, "username")
	UsernameField.send_keys(username)

	PasswordField = driver.find_element(:id, "password")
	PasswordField.send_keys(password)

	LoginButton = driver.find_element(:name, "login")
	LoginButton.click
end 

def course_search(driver, course)
	CourseSearch = driver.find_element(:link, "Search All Courses");
	CourseSearch.click;

	CourseCodeField = driver.find_element(:name, "REGCSE"); #thats the name of the input field...
	CourseCodeField.send_keys(course.code);

	SearchButton = driver.find_element(:xpath, "//input[@value='Search']"); #find the search button
	SearchButton.click;

	#the resultant table in the following page
	Table = driver.find_elements(:xpath, "//table")[0]; #first table in the page is the one we want
	TableRows = Table.find_elements(:tag_name, "tr"); #get the rows
	Courses = [] #initialize array for the rows matching the desired course
	column_index = course.get_column_index_to_check #the index of the column containing the 
	#most specific information; e.g. if course meet times is specified, check that column

	TableRows[1..-1].each do |row|
		if (row.find_elements)

