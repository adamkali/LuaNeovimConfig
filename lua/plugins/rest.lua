return {
	"mistweaverco/kulala.nvim",
	ft = { "rest", "http" },
	opts = {
		curl_path = "/usr/bin/curl",
		websocat_path = "/home/linuxbrew/.linuxbrew/bin/websocat",
		openssl_path = "/home/linuxbrew/.linuxbrew/bin/openssl",
		environment_scope = "b",
		default_env = "dev",
		halt_on_error = false,
		ui = {
			icons = {
				inlay = {
					loading = "",
					done = "󱊆",
					error = "󰱝",
				},
				lualine = "󰖟",
				textHighlight = "WarningMsg", -- highlight group for request elapsed time
				loadingHighlight = "Comment",
				doneHighlight = "String",
				errorHighlight = "ErrorMsg",
			},
			syntax_hl = {
				["@punctuation.bracket.kulala_http"] = "@function.builtin",
				["@character.special.kulala_http"] = "@character.special",
				["@operator.kulala_http"] = "@keyward.function",
				["@variable.kulala_http"] = "@variable.parameter",
				["@redirect_path.kulala_http"] = "@function.builtin",
				["@external_body_path.kulala_http"] = "String",
			},
		}
	}
}
