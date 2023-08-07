package com.hnt.dental.dto.response;

import com.hnt.dental.dao.impl.BlogDaoImpl;
import com.hnt.dental.entities.Blogs;

import com.hnt.dental.entities.CategoryBlog;
import com.hnt.dental.entities.Employee;
import com.hnt.dental.util.DateUtils;
import lombok.*;
import lombok.experimental.SuperBuilder;

import java.sql.SQLException;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
@SuperBuilder

public class BlogResDto {
    private long id;
    private CategoryBlog categoryBlog;
    private Employee employee;
    private String title;
    private String brief;
    private String description;
    private LocalDateTime create_at;
    private LocalDateTime update_at;
    private String image;
    private String status;
    private long created_by;


    public static List<BlogResDto> convert(List<Blogs> blogs) {
        List<BlogResDto> blogResDtos = new ArrayList<>();
        for (Blogs blog : blogs) {
            blogResDtos.add(
                    BlogResDto.builder()
                            .id(blog.getId())
                            .categoryBlog(
                                    CategoryBlog.builder().name(blog.getCategoryBlog().getName()).build()
                            ).employee(Employee.builder().fullName(blog.getEmployee().getFullName()).build())
                            .title(blog.getTitle())
                            .brief(blog.getBrief())
                            .description(blog.getDescription())
                            .create_at(blog.getCreatedAt())
                            .status(blog.getStatus() ? "Hiện" : "Ẩn")
                            .image(blog.getImage())
                            .build()
            );
        }
        return blogResDtos;
    }
}
