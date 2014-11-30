#this file holds the main function of the course-grabbing program.

def main_course() 
	course_names = ["EEL4744", "EES"]

	#selenium web drivers
	driver = Selenium::WebDriver.for(:firefox); 
	driver.get "http://isis.ufl.edu";