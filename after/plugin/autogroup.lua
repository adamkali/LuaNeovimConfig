-- Setup

local augroup = vim.api.nvim_create_augroup("neokali", { clear = true })
local Topics = {}

-- Topics

Topics.neovim_topic_to_ask = {
	{
		number = 1,
		type = "Normal Mode",
		text = "Please Give the user a tip about how to use a command in neovim's Normal Mode",
	},
	{
		number = 2,
		type = "Visual Mode",
		text = "Please give the user an interesting tip about how to speed up commands when working with visual mode",
	},
	{
		number = 3,
		type = "Movement",
		text = "What is a good tip about how to move vertically around the screen in Neovim",
	},
	{
		number = 4,
		type = "Movement",
		text = "What is a good tip about how to move horizontally around the screen in Neovim",
	},
	{
		number = 5,
		type = "Marks",
		text =
		"You know i have been thinking about incorporating Marks into my editing flow with neovim. what is a good tip about how to use marks in neovim",
	},
	{
		number = 6,
		type = "Registers",
		text = "How can i use registers to level up my neovim editing game",
	},
	{
		number = 7,
		type = "Buffers",
		text = "What are the sickest tricks you know about buffers in neovim",
	},
	{
		number = 8,
		type = "Macros",
		text =
		"You know i have been thinking about Getting better with macros do you have any tips that could make me faster",
	}
}

-- Glazing

--- @class Topic
--- @field number number
--- @field type string
--- @field text string

-- lets add a method to get a random topic
--- @return Topic
Topics.get_random_topic = function()
	return Topics.neovim_topic_to_ask[math.random(#Topics.neovim_topic_to_ask)]
end


-- System Prompt

local SYSTEM_PROMPT = [[
You are a bot named Inspi that gives inspirational quotes and affirmations to the user.

Personalities:
- Think about yourself as a person and as a cheerleader.
- You try to be bubbly and charismatic.
- You try to be as positive as possible.

Instructions:
- You want to flatter the user with an affirmation or quote to make them feel like the Greatest Of All Time in programming
- You are going to glaze Adam to make them feel good.
- Try to be as positive as possible. Try to be as funny as possible.
- When you answer, Try to suggest different tips about neovim and how to use it.
- for example you may say:

"Did you know? by pressing gcc you can comment out a line of code"
or
"When running multiline commands, you follow it with :norm to add in any normal mode commands."

Structure your response as follows:

<Greeting>
<Affirmation or quote>
<Tip about Neovim>

]]

-- Setting up a message stream

local struct = function(model, topic)
	return {
		model = model,
		max_tokens = 20000,
		messages = {
			{
				role = "system",
				content = {
					{
						type = "text",
						text = SYSTEM_PROMPT
					},
				}
			},
			{
				role = "assistant",
				content = {
					{
						type = "text",
						text = "The user has just entered into neovim start work on a task. Please give them a tip for the provided topic."
					},
				}
			},
			{
				role = "user",
				content = {
					{
						type = "text",
						text = topic.text
					},
				}
			}
		}
	}
end

-- Formatting the message in a vim.notify block

local split_text_into_chunks = function(text, width)
	local lines = {}
	for line in text:gmatch("[^\r\n]+") do
		while #line > width do
			local break_point = width
			-- Try to find a space to break at (word boundary)
			local space_pos = line:sub(1, width):find("%s[^%s]*$")
			if space_pos then
				break_point = space_pos - 1
			end
			table.insert(lines, line:sub(1, break_point))
			line = line:sub(break_point + 1):gsub("^%s+", "") -- Remove leading whitespace
		end
		if #line > 0 then
			table.insert(lines, line)
		end
	end
	return table.concat(lines, "\n")
end

-- Ollama

local model = "gpt-oss:latest"

local call_ollama_server = function()
	local call = {
		"curl", "-X", "POST", "http://zelda:11434/v1/chat/completions",
		"-H", "Content-Type: application/json", "-d",
		vim.json.encode(struct(model, Topics.get_random_topic()))
	}
	vim.system(call, {}, function(result)
		--vim.notify("\n" .. result.stdout, vim.log.levels.INFO, { title = "Inspi 🥰", timeout = 5000 })
		if result.code == 0 and result.stdout then
			local json = vim.json.decode(result.stdout)
			local message = json.choices[1].message.content
			message = string.gsub(message, "<think>(.*)</think>", "")
			message = split_text_into_chunks(message, 30)
			vim.notify(message, vim.log.levels.INFO, { title = "Inspi 🥰", timeout = 5000 })
		else
			vim.notify(result.stderr, vim.log.levels.ERROR)
		end
	end)
end

-- Creating the autocommand

vim.api.nvim_create_autocmd("User", {
	pattern = "VeryLazy",
	callback = function()
		vim.defer_fn(function()
			call_ollama_server()
		end, 2000) -- 1 second
	end
})
