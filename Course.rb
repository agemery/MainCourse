class Course
#this class will represent a course we are trying to add.
#since the course code is not necessarily unique to a particular
#course, a course name may also be needed to identify which
#course is the correct one when adding them.

	attr_reader :code, :name, :meet_times
	#meet_times is an array of Strings representing the acceptable
	#meeting times for the course
	#in the same format as seen in Firefox by Selenium.
	#alternatively ^, we could use section # instead....

	def initialize(course_code, course_name="", course_meet_times="")
		@code = course_code
		@name = course_name
		@meet_times = course_meet_times
	end 

	def check_match(row)
		#need to figure something out as far as checking the specific course
		return row.find_elements(:tag_name, "td")[0].text.include? @code
	end
			
end 