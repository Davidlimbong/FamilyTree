library(shiny)

shinyServer(function(input, output) { 
    
    
    
    output$tree <- renderCollapsibleTree({
        collapsibleTreeNetwork(df = df_fam[,1:2],   collapsed = F)
    })
    
    
    output$tree_filter <- renderCollapsibleTree({
        
        fam_tree <- df_fam[-1,] %>% 
            mutate_at(vars(parent, child), str_replace_all, " ", "_") %>% 
            FromDataFrameNetwork()
        
        name <- str_replace_all(input$treeid, " ", "_")
        
        FindNode(fam_tree,name) %>% 
            ToDataFrameNetwork() %>% 
            rename(parent = from, 
                   child = to) %>% 
            mutate_at(vars(parent, child), str_replace_all, "_", " ") %>% 
            left_join(df_fam) %>% 
            bind_rows( data.frame(parent = NA, child = name)) %>% 
            collapsibleTreeNetwork(df = .[,1:2], collapsed = F)
        
        
    })
    
    output$tree_search <- renderCollapsibleTree({
        
        
        fam_tree <- df_fam[-1,] %>% 
            mutate_at(vars(parent, child), str_replace_all, " ", "_") %>% 
            FromDataFrameNetwork()
        
        
        name1 <- str_replace_all(input$name1, " ", "_")
        name2 <- str_replace_all(input$name2, " ", "_")
        
        path1 <- FindNode(fam_tree, name1)$path
        path2 <- FindNode(fam_tree, name2)$path
        
        ancestor <- last(path1[path1 %in% path2]) 
        
        
        FindNode(fam_tree, ancestor) %>% 
            ToDataFrameNetwork() %>% 
            rename(parent = from, 
                   child = to) %>% 
            mutate_at(vars(parent, child), str_replace_all, "_", " ") %>% 
            left_join(df_fam) %>% 
            bind_rows( data.frame(parent = NA, child = ancestor)) %>% 
            mutate(col = case_when(child %in% str_replace_all(c(name1, name2), "_"," ") ~  "#cd2626", 
                                   child == ancestor ~ "#1874cd",
                                   TRUE ~ "#FFFFFF")) %>% 
            select(-generation) %>% 
            collapsibleTreeNetwork(collapsed = F, fill = "col")
        
        
        
    })
    

})
