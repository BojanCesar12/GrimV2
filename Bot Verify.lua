local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local Window = Rayfield:CreateWindow({
    Name = "Bot Verification",
    Icon = 0, -- Icon in Topbar. Can use Lucide Icons (string) or Roblox Image (number). 0 to use no icon (default).
    LoadingTitle = "Bot Verification",
    LoadingSubtitle = "Loading Verify Quiz...",
    Theme = "Serenity", -- Check https://docs.sirius.menu/rayfield/configuration/themes

    DisableRayfieldPrompts = false,
    DisableBuildWarnings = false, -- Prevents Rayfield from warning when the script has a version mismatch with the interface

    ConfigurationSaving = {
    Enabled = false,
    FolderName = nil, -- Create a custom folder for your hub/game
    FileName = "bot-GrimV2"
    },

    Discord = {
    Enabled = false, -- Prompt the user to join your Discord server if their executor supports it
    Invite = "noinvitelink", -- The Discord invite code, do not include discord.gg/. E.g. discord.gg/ ABCD would be ABCD
    RememberJoins = true -- Set this to false to make them join the discord every time they load it up
    },

    KeySystem = false, -- Set this to true to use our key system
    KeySettings = {
    Title = "",
    Subtitle = "",
    Note = "", -- Use this to tell the user how to get a key
    FileName = "", -- It is recommended to use something unique as other scripts using Rayfield may overwrite your key file
    SaveKey = false, -- The user's key will be saved, but if you change the key, they will be unable to use your script
    GrabKeyFromSite = false, -- If this is true, set Key below to the RAW site you would like Rayfield to get the key from
    Key = {""} -- List of keys that will be accepted by the system, can be RAW file links (pastebin, github etc) or simple strings ("hello","key22")
    }
})


------------------------------------ Tabs ------------------------------------

local QuizTab = Window:CreateTab("Quiz")



--------------------------------------------------------------------------

local QuizSection = QuizTab:CreateSection("Question's")

-- Quiz questions and answers
local questions = {
    {
        Text = "12+5",
        Answer = "17"
    },
    {
        Text = "17-8",
        Answer = "9"
    },
    {
        Text = "8x2",
        Answer = "16"
    }
}

-- Store user answers
local userAnswers = {}

-- Create question inputs
for i, question in ipairs(questions) do
    QuizTab:CreateLabel(question.Text)
    
    QuizTab:CreateInput({
        Name = "Answer "..i,
        PlaceholderText = "Type answer here...",
        RemoveTextAfterFocusLost = false,
        Callback = function(Text)
            -- Store cleaned answer (lowercase, no spaces)
            userAnswers[i] = string.lower(string.gsub(Text, "%s+", ""))
        end,
    })
end

local QuizSection = QuizTab:CreateSection("Sumbit Answers")

-- Create submit button
local SubmitButton = QuizTab:CreateButton({
    Name = "Sumbit Answers",
    Callback = function()
        -- Check if all questions were answered
        for i = 1, #questions do
            if not userAnswers[i] or userAnswers[i] == "" then
                Rayfield:Notify({
                    Title = "Missing Answer",
                    Content = "Please answer question "..i,
                    Duration = 3
                })
                return
            end
        end
        
        -- Validate answers
        local allCorrect = true
        for i, question in ipairs(questions) do
            if userAnswers[i] ~= question.Answer then
                allCorrect = false
                Rayfield:Notify({
                    Title = "Incorrect",
                    Content = "Question "..i.." was wrong",
                    Duration = 2
                })
            end
        end
        
        -- Load GrimV2 if all correct
        if allCorrect then
            Rayfield:Destroy() -- Close the Rayfield window first
            
            -- Load GrimV2 directly without confirmation
            local success, err = pcall(function()
                loadstring(game:HttpGet("https://raw.githubusercontent.com/BojanCesar12/GrimV2/refs/heads/main/Grow%20a%20Garden", true))()
            end)
            
            if not success then
                warn("Failed to load GrimV2: "..tostring(err))
                Rayfield:Notify({
                    Title = "Load Error",
                    Content = "Failed to load GrimV2 script",
                    Duration = 5
                })
            end
        end
    end,
})