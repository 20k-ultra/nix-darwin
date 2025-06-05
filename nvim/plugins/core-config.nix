{ ... }: {
  extraConfigLua = ''
    -- Smart buffer close function that prevents focus moving to nvim-tree
    -- and closes editor when no buffers remain
    local function smart_close_buffer()
      local current_buf = vim.api.nvim_get_current_buf()
      local current_win = vim.api.nvim_get_current_win()
     
      -- Get all valid, listed buffers except the current one
      local buffers = vim.tbl_filter(function(buf)
        return vim.api.nvim_buf_is_valid(buf) 
          and vim.bo[buf].buflisted 
          and buf ~= current_buf
      end, vim.api.nvim_list_bufs())
     
      -- If no other buffers exist, close the editor
      if #buffers == 0 then
        vim.cmd("qall")
        return
      end
     
      -- If we're in nvim-tree or there are other buffers available
      if vim.bo.filetype == "NvimTree" or #buffers > 0 then
        -- Find a non-nvim-tree window to focus
        local windows = vim.api.nvim_list_wins()
        for _, win in ipairs(windows) do
          local win_buf = vim.api.nvim_win_get_buf(win)
          local ft = vim.bo[win_buf].filetype
          if ft ~= "NvimTree" and ft ~= "help" and ft ~= "qf" and ft ~= "quickfix" then
            vim.api.nvim_set_current_win(win)
            if #buffers > 0 then
              vim.cmd("buffer " .. buffers[1])
            end
            break
          end
        end
      end
     
      -- Close the buffer
      vim.cmd("bdelete " .. current_buf)
    end

    -- Make the function globally available
    _G.smart_close_buffer = smart_close_buffer

    -- enforce a quit all behaviour so calling quit once closes editor
    vim.cmd([[
      cnoreabbrev wq write<bar>qall
      cnoreabbrev Wq write<bar>qall  
      cnoreabbrev WQ write<bar>qall
    ]])

    -- UTF-8 encoding
    vim.opt.encoding = "UTF-8"

    -- Nerd font setting
    vim.g.have_nerd_font = true
  '';
}

