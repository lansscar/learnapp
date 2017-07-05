module StaticPagesHelper
	def full_title(title = '')
		base_title = "Test app"
		if title.empty?
			base_title
		else
			title + " |" + base_title
		end
	end
end
