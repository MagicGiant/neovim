local function get_header()
	return {
		"",
		"",
		"",
		"",
		"",
		"",
		"░██████╗██╗░░██╗███████╗██████╗░██╗░░██╗░█████╗░░░░██╗░░░██╗██╗███╗░░░███╗",
		"██╔════╝██║░░██║██╔════╝██╔══██╗██║░██╔╝██╔══██╗░░░██║░░░██║██║████╗░████║",
		"╚█████╗░███████║█████╗░░██████╔╝█████═╝░███████║░░░╚██╗░██╔╝██║██╔████╔██║",
		"░╚═══██╗██╔══██║██╔══╝░░██╔══██╗██╔═██╗░██╔══██║░░░░╚████╔╝░██║██║╚██╔╝██║",
		"██████╔╝██║░░██║███████╗██║░░██║██║░╚██╗██║░░██║██╗░░╚██╔╝░░██║██║░╚═╝░██║",
		"╚═════╝░╚═╝░░╚═╝╚══════╝╚═╝░░╚═╝╚═╝░░╚═╝╚═╝░░╚═╝╚═╝░░░╚═╝░░░╚═╝╚═╝░░░░░╚═╝",
		"													your vscode is bullshit",
		"",
		"",
		"",
	}
end

require("dashboard").setup({
  theme = 'doom',
  config = {
    header =  get_header(), --your header
    center = {
      {
        icon = ' ',
        icon_hl = 'Title',
        desc = 'Find File',
        desc_hl = 'String',
        key = 'a',
        keymap = 'SPC f f',
        key_hl = 'Number',
        key_format = ' %s', -- remove default surrounding `[]`
        action = 'Telescope find_files'
      },
			{
				icon = ' ',
				icon_hl = 'Title',
        desc = 'Blow up Microsoft servers',
        desc_hl = 'String',
        key = 'b',
        key_format = ' %s',
        action = 'Telescope find_files'
			}
    },
    footer = {}  --your footer
  }})
