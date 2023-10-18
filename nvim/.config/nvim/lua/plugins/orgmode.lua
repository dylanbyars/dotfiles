return {
	"nvim-orgmode/orgmode",
	opts = {
		org_indent_mode = "noindent",
		org_agenda_files = { "~/org/*" },
		mappings = {
			org = {
				org_toggle_checkbox = "<leader><leader>",
			},
		},
		org_capture_templates = {
			t = {
				description = "TODO",
				template = "* TODO %?\n  %U",
				target = "~/org/todo.org",
			},
			j = {
				description = "Journal",
				template = "* %U\n\n%?",
				target = "~/org/journal.org",
			},
			d = {
				description = "Dump",
				template = "* %?",
				target = "~/org/dump.org",
			},
		},
	},
}
