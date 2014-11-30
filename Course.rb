class Course
#this class will represent a course we are trying to add.
#since the course code is not necessarily unique to a particular
#course, a course name may also be needed to identify which
#course is the correct one when adding them.

	attr_reader :code, :name, :meet_times
	#meet_times would only be used when you want
	#a SPECIFIC course time. meet_times shall be stored as a String
	#in the same format as seen in Firefox by Selenium.
	#alternatively ^, we could use section # instead....

	def initialize(course_code, course_name="", course_meet_times="")
		@code = course_code
		@name = course_name
		@meet_times = meet_times
	end 

end 