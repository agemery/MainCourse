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

	def sign_up(driver)
		section_numbers.each do |s|
			if (visit_specific_course(driver, s))
				return true
			end
		end
		#return false if the loop does not add any section number
		return false 
	end

	def merge_course(course)
		if course.instance_of? Course
			return self
		elsif course.instance_of? SpecificCourse
			@section_numbers += course.section_numbers
			return self
		else
			super
		end		
	end

	def to_string()
		sb = super + ":"
		@section_numbers.each do |s|
			sb += "\n\t" + s
		end
		return sb
	end

end