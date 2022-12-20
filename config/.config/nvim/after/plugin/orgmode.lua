require("orgmode").setup({
	org_agenda_files = { "~/org/*" },
	org_default_notes_file = "~/org/refile.org",
	mappings = {
		org = {
			org_toggle_checkbox = "<M-Space>",
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
})
