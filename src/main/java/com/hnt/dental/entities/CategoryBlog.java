package com.hnt.dental.entities;

import lombok.*;
import lombok.experimental.SuperBuilder;

@Setter
@Getter
@NoArgsConstructor
@AllArgsConstructor
@SuperBuilder
public class CategoryBlog extends BaseEntity{

    private String name;

}
