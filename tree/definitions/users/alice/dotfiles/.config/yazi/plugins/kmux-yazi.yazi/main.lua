--- @sync entry
return {
	entry = function(_, job)
		if os.getenv("KMUX_YAZI") then
			return -- override for this session: do nothing (or ya.emit something else)
		end
		ya.emit(job.args[1], {}) -- normal behavior everywhere else
	end,
}
