package com.hnt.dental.entities;

import lombok.*;
import lombok.experimental.SuperBuilder;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
@SuperBuilder
public class  Blogs extends BaseEntity{
    private CategoryBlog categoryBlog;
    private Employee employee;
    private String title;
    private String brief;
    private String description;
    private Boolean status;
    private String image;
    private long categoryID;
}
