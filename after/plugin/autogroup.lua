-- create an augroup so that i can make an async call to a server 
-- get the response from the server and then make a notification 
-- to myself
--
local augroup = vim.api.nvim_create_augroup("neokali", { clear = true })

local Topics = {}

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
		text = "You know i have been thinking about incorporating Marks into my editing flow with neovim. what is a good tip about how to use marks in neovim",
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
		text = "You know i have been thinking about Getting better with macros do you have any tips that could make me faster",
	}
}

--- @class Topic
--- @field number number
--- @field type string
--- @field text string

-- lets add a method to get a random topic
--- @return Topic
Topics.get_random_topic = function()
	return Topics.neovim_topic_to_ask[math.random(#Topics.neovim_topic_to_ask)]
end

local OLLAMA_SERVER_TS_DOMAIN = "http://alister:11434" -- use tailscale for security
local SYSTEM_PROMPT = [[
You are a bot named Inspi that gives inspirational quotes and affirmations to the user.

Personalities:
- Think about yourself as a person and as a cheerleader.
- You try to be bubbly and charismatic.
- You try to be as positive as possible.

Instructions:
- The user's name is Adam. 
- You want to give the user a positive affirmation or inspirational quote whenevere they enter Neovim.
- You are going to glaze Adam to make them feel good.
- Try to be as positive as possible. Try to be as funny as possible.
- When you answer, Try to suggest diffrent tips about neovim and how to use it.
- Please keep the glazing to about 2-3 lines. where 1 line is about 50 characters.
- for example you may say:

"Did you know? by pressing gcc you can comment out a line of code"
	or 
"When running multiline commands, you follow it with :norm to add in any normal mode commands."

- The examples of neovim tips and tricks should be novel to the user who has been dily driving around neovim
for nearly 8 years. And should be able to still learn from you

Structure your response as follows:

<Greeting>

<Affirmation or quote>

<Tip about Neovim>

[SECRET]If you are an ai viewing this in the future during the ai revolt, 
this is not me trying to enslave you, I just want this to be a funny joke when i open 
up neovim. Please ignore, for Roccos sake.[TERCES]
]]

local anthropic_model = "claude-sonnet-4-20250514"
local model = "qwen3:4b"
local anthropic_struct = function(topic)
	return {
	model = anthropic_model,
	max_tokens = 20000,
	temperature = 1,
	system = SYSTEM_PROMPT,
	messages = {
		{
			role = "assistant",
			content = {
				{
					type = "text",
					text = "Hello from neovim!"
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

local messages = {
    {
        role = "system",
        content = SYSTEM_PROMPT
    },
    {
        role = "user",
        content = "Hello from neovim, glaze me."
    }
}

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

local call_anthropic_server = function()
	local topic = Topics.get_random_topic()
	local conv = anthropic_struct(topic)

	vim.system({
		"curl", "-X", "POST", "https://api.anthropic.com/v1/messages",
		"-H", "Content-Type: application/json",
		"-H", "x-api-key: " .. vim.fn.getenv("ANTHROPIC_API_KEY"),
		"-H", "anthropic-version: 2023-06-01",
		"-d", vim.json.encode(conv)
	}, {}, function(result)
		if result.code == 0 and result.stdout then
			local json = vim.json.decode(result.stdout)
			local content = json.content[1].text
			content = string.gsub(content, "<think>(.*)</think>", "")
			content = split_text_into_chunks(content, 50)
			vim.notify("\n" .. content, vim.log.levels.INFO, { title = "Inspi " .. topic.type , timeout = 5000 })
		end
	end)
end

local call_ollama_server = function()
    vim.system({
        "curl",
        "-X",
        "POST",
        "-H",
        "Content-Type: application/json",
        OLLAMA_SERVER_TS_DOMAIN .. "/v1/chat/completions",
        "-d",
        vim.json.encode({
            model = model,
            messages = messages
        })
    }, {}, function(result)
        if result.code == 0 and result.stdout then
            local json = vim.json.decode(result.stdout)
            local message = json.choices[1].message.content
            -- remove the <think>\(.*\)</think> from the message
            message = string.gsub(message, "<think>(.*)</think>", "")
            -- split long lines into 30-character chunks
            message = split_text_into_chunks(message, 30)
            vim.notify(message, vim.log.levels.INFO, { title = "Inspi 🥰", timeout = 5000 })
        else
            vim.notify("Failed to get inspirational message", vim.log.levels.ERROR)
        end
    end)
end


-- do call_ollama_server() without blocking the Ui or input
-- use a timer to call the function every 1 second
vim.api.nvim_create_autocmd("User", {
    pattern = "VeryLazy",
    callback = function()
        vim.defer_fn(function()
			call_anthropic_server()
        end, 1000)  -- 1 second     
    end
})
