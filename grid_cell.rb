class Grid_Cell

	attr_accessor: :row, :column, :status

	def initialize(row, column, status)
		@row = row
		@column = column
		@status = :open
	end

end