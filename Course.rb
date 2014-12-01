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

	def get_column_index_to_check()
		if (!meet_times.eql? "")
			return 3 #not sure if this is the right column change it later
		elsif (!name.eql? "")
			return 2 #again not sure right now but w/e
		else
			return 0
		end
	end
			
end 