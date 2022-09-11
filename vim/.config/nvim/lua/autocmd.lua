-- TODO: provide fallback functions
if vim.api.nvim_create_autocmd == nil then
  error('This version of NeoVim does not support autocmd api')
end

vim.api.nvim_create_autocmd({ 'ColorScheme' }, {
    desc = 'Make inactive statusline more visible.',
    pattern = { 'material' },
    command = 'hi! link StatusLineNC Visual',
});

vim.api.nvim_create_autocmd({ 'TextYankPost' }, {
    desc = 'Highlight yanked text',
    pattern = { '*' },
    callback = function ()
        vim.highlight.on_yank({
            higroup = 'CursorIM',
            timeout = 300,
        })
    end
});

vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
    desc = 'Highlight yanked text',
    pattern = { '*.snippets' },
    command = 'setfiletype snippets',
});
