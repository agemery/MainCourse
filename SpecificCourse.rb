class SpecificCourse < Course
#for courses which require more than just a course code 
#(e.g. CIS4930 identifies several different courses)
#section_number is optional, and will be specified only if ya need it
#assuming section numbers are unique...

	attr_reader :section_numbers

	def initialize(course_code, section_numbers=[])
		@code = course_code 
		#lets leave this out for now..
		#@name = course_name
		@section_numbers = section_numbers
	end 

	def sign_up()
		return visit_specific_course(self)
	end

end