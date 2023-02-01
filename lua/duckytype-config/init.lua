require'duckytype'.setup{
    number_of_words = 20,
    window_config={border = "rounded"},
    expected = "rust_keywords",
    highlight = {
        good = "Normal",
        bad = "Identifier",
        remaining = 'Comment'
    }
}
