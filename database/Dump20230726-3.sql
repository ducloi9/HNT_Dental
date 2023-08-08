-- MySQL dump 10.13  Distrib 8.0.31, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: hnt_dental
-- ------------------------------------------------------
-- Server version	8.0.30

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `accounts`
--

DROP TABLE IF EXISTS `accounts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `accounts` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `role` int NOT NULL,
  `is_verified` tinyint(1) NOT NULL,
  `image` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `accounts`
--

LOCK TABLES `accounts` WRITE;
/*!40000 ALTER TABLE `accounts` DISABLE KEYS */;
INSERT INTO `accounts` VALUES (1,'admin1@hnt.dental.vn','RaSPt3Mw4QXovbwGnk8TzA',1,1,'https://www.hanhphuchospital.com/wp-content/uploads/2023/06/Orly-web-277x327.jpg','2023-07-24 00:00:00','2023-07-24 00:00:00'),(2,'admin2@hnt.dental.vn','RaSPt3Mw4QXovbwGnk8TzA',1,1,'https://www.hanhphuchospital.com/wp-content/uploads/2020/01/Bs-Vu-Quang-Vinh-1-277x327.jpg','2023-07-24 00:00:00','2023-07-24 00:00:00'),(3,'linhbt@hnt.dental.vn','RaSPt3Mw4QXovbwGnk8TzA',3,1,'https://www.hanhphuchospital.com/wp-content/uploads/2023/02/6cf99b782f66f538ac77-277x327.png','2023-07-24 00:00:00','2023-07-24 00:00:00'),(4,'mybt@hnt.dental.vn','RaSPt3Mw4QXovbwGnk8TzA',3,1,'https://www.hanhphuchospital.com/wp-content/uploads/2023/01/TS-BS-Nguye%CC%82%CC%83n-Va%CC%86n-Thanh-min-1.png','2023-07-24 00:00:00','2023-07-24 00:00:00'),(5,'trangnth@hnt.dental.vn','RaSPt3Mw4QXovbwGnk8TzA',3,1,'https://www.hanhphuchospital.com/wp-content/uploads/2020/01/Bs-Le-Van-Duc_1-3-277x327.jpg','2023-07-24 00:00:00','2023-07-24 00:00:00'),(6,'khanhtq@hnt.dental.vn','RaSPt3Mw4QXovbwGnk8TzA',4,1,'https://www.hanhphuchospital.com/wp-content/uploads/2020/01/Bs-Ho-Nguyen-Tien-1-277x327.jpg','2023-07-24 00:00:00','2023-07-24 00:00:00'),(7,'tuannt@hnt.dental.vn','RaSPt3Mw4QXovbwGnk8TzA',4,1,'https://www.hanhphuchospital.com/wp-content/uploads/2020/01/Bs-Nguyen-Ngoc-Mai-Huy-1-277x327.jpg','2023-07-24 00:00:00','2023-07-24 00:00:00'),(8,'khanhpq@hnt.dental.vn','RaSPt3Mw4QXovbwGnk8TzA',4,1,'https://www.hanhphuchospital.com/wp-content/uploads/2020/01/Bs-Nguyen-Thi-Tuyet-Anh-277x327.jpg','2023-07-24 00:00:00','2023-07-24 00:00:00'),(9,'tientd@hnt.dental.vn','RaSPt3Mw4QXovbwGnk8TzA',4,1,'https://www.hanhphuchospital.com/wp-content/uploads/2020/01/Bs-Vu-Van-Phi-3-277x327.jpg','2023-07-24 00:00:00','2023-07-24 00:00:00'),(10,'trunglq@hnt.dental.vn','RaSPt3Mw4QXovbwGnk8TzA',4,1,'https://www.hanhphuchospital.com/wp-content/uploads/2020/01/Bs-Nguyen-Huu-Thuan-277x327.jpg','2023-07-24 00:00:00','2023-07-24 00:00:00'),(11,'doannt@hnt.dental.vn','RaSPt3Mw4QXovbwGnk8TzA',4,0,'https://www.hanhphuchospital.com/wp-content/uploads/2020/01/Bs-Tran-Duc-Tuan-Copy-1.jpg','2023-07-24 00:00:00','2023-07-24 00:00:00'),(12,'thaolv@hnt.dental.vn','RaSPt3Mw4QXovbwGnk8TzA',4,0,'https://www.hanhphuchospital.com/wp-content/uploads/2020/01/BS-Le-Anh-Tai-2-277x327.jpg','2023-07-24 00:00:00','2023-07-24 00:00:00'),(13,'huynt@hnt.dental.vn','RaSPt3Mw4QXovbwGnk8TzA',4,1,'https://www.hanhphuchospital.com/wp-content/uploads/2020/01/Bs-Ho-Thi-Hoang-Anh-277x327.jpg','2023-07-24 00:00:00','2023-07-24 00:00:00'),(14,'thuongntk@hnt.dental.vn','RaSPt3Mw4QXovbwGnk8TzA',4,1,'https://www.hanhphuchospital.com/wp-content/uploads/2020/01/Bs-Hoang-Ngoc-Hai-1-277x327.jpg','2023-07-24 00:00:00','2023-07-24 00:00:00'),(15,'liennt@hnt.dental.vn','RaSPt3Mw4QXovbwGnk8TzA',4,1,'https://www.hanhphuchospital.com/wp-content/uploads/2020/01/Bs-Phan-Cao-Minh-1-277x327.jpg','2023-07-24 00:00:00','2023-07-24 00:00:00'),(16,'anpt@hnt.dental.vn','RaSPt3Mw4QXovbwGnk8TzA',2,1,'https://www.hanhphuchospital.com/wp-content/uploads/2020/01/Bs-Nguyen-Thi-Trang-Khanh-Linh-1-277x327.jpg','2023-07-24 00:00:00','2023-07-24 00:00:00'),(17,'annt@hnt.dental.vn','RaSPt3Mw4QXovbwGnk8TzA',2,1,'https://www.hanhphuchospital.com/wp-content/uploads/2020/01/Bs-Tieu-Thanh-Lieu-277x327.jpg','2023-07-24 00:00:00','2023-07-24 00:00:00'),(18,'truongpd@hnt.dental.vn','RaSPt3Mw4QXovbwGnk8TzA',2,1,'https://www.hanhphuchospital.com/wp-content/uploads/2019/12/Bs-Nguyen-Van-Nhan-277x327.jpg','2023-07-24 00:00:00','2023-07-24 00:00:00'),(19,'manhnd@hnt.dental.vn','RaSPt3Mw4QXovbwGnk8TzA',2,1,'https://www.hanhphuchospital.com/wp-content/uploads/2019/12/Bs-Trinh-Minh-Duc-277x327.jpg','2023-07-24 00:00:00','2023-07-24 00:00:00'),(20,'huynh@hnt.dental.vn','RaSPt3Mw4QXovbwGnk8TzA',2,1,'https://www.hanhphuchospital.com/wp-content/uploads/2021/03/Bs-Dang-Thanh-Binh-Copy.jpg','2023-07-24 00:00:00','2023-07-24 00:00:00'),(21,'minhpcd@hnt.dental.vn','RaSPt3Mw4QXovbwGnk8TzA',2,1,'https://www.hanhphuchospital.com/wp-content/uploads/2019/12/Bs-Bui-Long-Than-277x327.jpg','2023-07-24 00:00:00','2023-07-24 00:00:00'),(22,'huyen@gmail.com','RaSPt3Mw4QXovbwGnk8TzA',0,1,'https://res.cloudinary.com/dmc5jnvrs/image/upload/v1690333083/mic9wopo4c0zarpiq0km.jpg',NULL,NULL),(23,'hung@gmail.com','RaSPt3Mw4QXovbwGnk8TzA',0,1,NULL,'2023-07-24 00:00:00','2023-07-24 00:00:00'),(24,'bao@gmail.com','RaSPt3Mw4QXovbwGnk8TzA',0,1,NULL,'2023-07-24 00:00:00','2023-07-24 00:00:00'),(25,'dinhmanh@gmail.com','RaSPt3Mw4QXovbwGnk8TzA',0,1,NULL,'2023-07-24 00:00:00','2023-07-24 00:00:00'),(26,'tuan@gmai.com','RaSPt3Mw4QXovbwGnk8TzA',0,1,NULL,'2023-07-24 00:00:00','2023-07-24 00:00:00'),(27,'meo12@gmail.com','RaSPt3Mw4QXovbwGnk8TzA',0,1,NULL,'2023-07-24 00:00:00','2023-07-24 00:00:00');
/*!40000 ALTER TABLE `accounts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `blogs`
--

DROP TABLE IF EXISTS `blogs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `blogs` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `category_id` bigint DEFAULT NULL,
  `title` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `description` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `brief` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `create_at` datetime DEFAULT NULL,
  `update_at` datetime DEFAULT NULL,
  `created_by` bigint DEFAULT NULL,
  `status` tinyint DEFAULT NULL,
  `image` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `blogs`
--

LOCK TABLES `blogs` WRITE;
/*!40000 ALTER TABLE `blogs` DISABLE KEYS */;
INSERT INTO `blogs` VALUES (1,1,'Công nghệ cấy implant SAFEST nhanh tại Nha Khoa HNT','Khó mà tin những công nghệ đã phát triển vượt bật ngày nay trong lĩnh vực nha khoa triển khai trên toàn thế giới. Thế giới mở hơn nên dường như không có ứng dụng nào trên thế giới mà người dân Việt Nam chúng ta không có được. Cái khó ở đây  là tính kỷ luật của nhân tố con người Việt,  làm sao áp dụng đúng và đồng bộ. Nhưng cũng may mắn thay, trong bối cảnh dịch bệnh,','Công nghệ cấy implant SAFEST nhanh tại Nha Khoa Kim','2023-03-04 00:00:00','2023-03-04 00:00:00',3,1,'https://nhakhoakim.com/wp-content/uploads/2023/07/NKK_WEB-6-7-04.jpg'),(2,1,'Nha Khoa HNT triển khai dịch vụ răng sứ Implant nhanh','Nhu cầu làm răng sứ và cấy ghép Implant nhanh là những mong muốn không những của khách hàng mà đó còn là nỗi lo của từng bác sĩ, của các phòng khám nha khoa. Điều đó đã không còn khó khăn ngay cả những trường hợp mà răng và xương không thuận. Nhờ sự phối hợp đồng bộ giữa các bộ phận từ Lab đến lâm sàng và việc ứng dụng thành công công nghệ số đã giúp Nha Khoa Kim đảm bảo quy trình 8 tiếng hoàn tất sản phẩm răng sứ đạt chuẩn đối với sứ đơn lẻ nếu không có vấn đề bệnh lý về răng đi kèm.','Nhu cầu làm răng sứ và cấy ghép Implant nhanh là những mong muốn không những của khách hàng mà đó còn là nỗi lo của từng bác sĩ, của các phòng khám nha khoa. Điều đó đã không còn khó khăn ngay cả những trường hợp mà răng và xương không thuận. Nhờ sự phối hợp đồng bộ giữa các bộ phận từ Lab đến lâm sàng và việc ứng dụng thành công công nghệ số đã giúp Nha Khoa Kim đảm bảo quy trình 8 tiếng hoàn tất sản phẩm răng sứ đạt chuẩn đối với sứ đơn lẻ nếu không có vấn đề bệnh lý về răng đi kèm.','2023-03-04 00:00:00','2023-03-04 00:00:00',3,1,'https://nhakhoakim.com/wp-content/uploads/2022/08/Implant-X-Guide.jpg'),(3,1,'Nha Khoa  HNT tự hào là đối tác toàn cầu của Đại học Harvard','Nha Khoa HNT đã đón các thành viên Harvard Business School đến nghiên cứu và đưa ra những giải pháp nâng cao hành trình trải nghiệm khách hàng.\n\nĐây là hoạt động nằm trong chương trình FIELD Global Immersion của Harvard Business School. Năm nay, Nha Khoa Kim là một trong 171 đối tác toàn cầu của FIELD Global Immersion trải rộng trên 15 quốc gia và là đối tác trong lĩnh vực nha khoa tại Việt Nam.','Nha Khoa HNT đã đón các thành viên Harvard Business School đến nghiên cứu và đưa ra những giải pháp nâng cao hành trình trải nghiệm khách hàng.\n\nĐây là hoạt động nằm trong chương trình FIELD Global Immersion của Harvard Business School. Năm nay, Nha Khoa HNT là một trong 171 đối tác toàn cầu của FIELD GlNha Khoa HNT và sứ mệnh chăm sóc sức khỏe răng miệng Việt Nam qua hệ thống nha khoa chuẩn quốc tế\nVới sứ mệnh “Kiến tạo hệ sinh thái nha khoa cực kỳ đơn giản, phụng sự con người nhanh nhất trên mọi miền đất nước”, Nha Khoa HNT luôn chú trọng xây dựng hệ thống nha khoa chuẩn hóa, đồng bộ ở tất cả ở các cơ sở về đội ngũ bác sĩ được đào tạo tại các trường đại học y khoa nổi tiếng trong và ngoài nước; về việc đầu tư máy móc tiên tiến giúp hỗ trợ chẩn đoán, điều trị chính xác; về ứng dụng công nghệ quản lý trải nghiệm dịch vụ khách hàng ngay từ lúc bước vào đến khi rời khỏi phòng khám.','2023-03-04 00:00:00','2023-03-04 00:00:00',3,1,'https://nhakhoakim.com/wp-content/uploads/2023/05/nha-khoa-kim-la-doi-tac-cua-dai-hoc-Harvard-3-scaled.jpg'),(4,1,'Nha Khoa HNT đầu tư Robot X-guide cấy ghép Implant công nghệ Hoa Kỳ','Công nghệ cấy ghép Implant bằng Robot định vị X-guide được Bác sĩ Nguyễn Hữu Nam – Chủ tịch Hội đồng Quản trị Nha Khoa HNT cùng Bác sĩ Keni Kubo – Giám đốc điều hành Envista đã cùng có mặt và thực hiện lễ bàn giao Robot X-Guide, công nghệ hiện đại bậc nhất thế giới trong định vị và cấy ghép răng implant.','Tự hào là hệ thống nha khoa đạt chuẩn quốc tế phủ rộng khắp Việt Nam, Nha Khoa HNT không ngừng đầu tư cơ sở vật chất, trang thiết bị hiện đại để có thể phụng sự và mang lại những giá trị dịch vụ tốt nhất dành cho các khách hàng.\nCông nghệ định vị cấy ghép răng Implant (X-guide Navigation) được nghiên cứu và giới thiệu lần đầu tiên bởi Bác sĩ Nardy Casap vào năm 2004. Trải qua hơn 16 năm với nhiều lần cải tiến, đến nay công nghệ này được đánh giá là công nghệ hiện đại nhất trong Implant nha khoa và được ứng dụng tại các quốc gia phát triển như Anh, Pháp, Đức, Úc, Ý,…','2023-03-04 00:00:00','2023-03-04 00:00:00',3,1,'https://nhakhoakim.com/wp-content/uploads/2022/08/NKK_hinh-buoi-trao-may-xguide-web-02-scaled.jpg'),(5,2,'Nha Khoa HNT hợp tác đào tạo ngành Răng Hàm Mặt cùng Đại học Trà Vinh','Tuần qua, Nha Khoa HNT và Đại học Trà Vinh đã có buổi ký kết hợp tác đào tạo trong lĩnh vực Răng - Hàm - Mặt. Sự kiện một lần nữa khẳng định sự quan tâm sâu sắc của Nha Khoa HNT đến việc đào tạo, phát triển nguồn nhân lực chất lượng để phục vụ tốt nhất nhu cầu chăm sóc răng miệng của người dân trên mọi miền đất nước.     Tham dự lễ ký kết, đại diện Nha...','Tuần qua, Nha Khoa Kim và Đại học Trà Vinh đã có buổi ký kết hợp tác đào tạo trong lĩnh vực Răng – Hàm – Mặt. Sự kiện một lần nữa khẳng định sự quan tâm sâu sắc của Nha Khoa Kim đến việc đào tạo, phát triển nguồn nhân lực chất lượng để phục vụ tốt nhất nhu cầu chăm sóc răng miệng của người dân trên mọi miền đất nước.','2023-03-04 00:00:00','2023-03-04 00:00:00',3,1,'https://nhakhoakim.com/wp-content/uploads/2023/06/NKK_post-le-ki-ket-hop-tac-07-scaled.jpg'),(6,2,'Chào mừng Đại Học Y Hải Phòng tham quan mô hình Nha Khoa HNT','Ngày 30/11/2022 Đoàn đại biểu Trường ĐH Y Hải Phòng gồm:','Nội dung tham quan:','2023-03-04 00:00:00','2023-03-04 00:00:00',3,1,'https://nhakhoakim.com/wp-content/uploads/2022/11/6-1.jpg'),(7,2,'Nha Khoa HNT đạt Top 100 Sản Phẩm – Dịch Vụ tin dùng Việt Nam 2022','Ngày 07/12/2022, Nha Khoa Kim tự hào được vinh danh “TOP 100 sản phẩm – dịch vụ tin dùng Việt Nam 2022” trong khuôn khổ Chương trình Tin dùng Việt Nam 2022 do Tạp chí Kinh tế Việt Nam – VnEconomy tổ chức.','Chương trình Tin dùng Việt Nam là sự kiện thường niên được Tạp chí Kinh tế Việt Nam khởi xướng và duy trì từ năm 2006 đến nay. Năm 2022, trọng tâm của chương trình là Lễ công bố và vinh danh “TOP 100 sản phẩm – dịch vụ tin dùng Việt Nam 2022”. \n\nVới chủ đề “Nền tảng số, củng cố niềm tin” năm nay, tiêu chí đánh giá và bình chọn “TOP 100 sản phẩm – dịch vụ tin dùng Việt Nam 2022” tập trung vào các sản phẩm – dịch vụ sáng tạo, đổi mới để tăng tốc phục hồi hậu đại dịch, mang đến được cho khách hàng những trải nghiệm tốt. ','2023-03-04 00:00:00','2023-03-04 00:00:00',4,1,'https://nhakhoakim.com/wp-content/uploads/2022/12/NKK_vinh-danh-top-100-sp-02.jpg'),(8,2,'Chúc mừng Nha Khoa Kim được chuyển giao công nghệ máy scan iTero hiện đại hàng đầu thế giới','Sáng ngày 10/12/2021, buổi lễ chuyển giao công nghệ Scan iTero giữa Nha Khoa Kim và Công ty Invisalign Việt Nam đã diễn ra thành công tốt đẹp.','Chia sẻ tại buổi lễ, bác sĩ Nguyễn Hữu Nam nhấn mạnh việc đầu tư máy scan iTero thể hiện mục tiêu không ngừng nâng cao trải nghiệm khách hàng cũng như hỗ trợ đội ngũ bác sĩ chẩn đoán chính xác, tăng hiệu quả điều trị cho từng khách hàng, đặc biệt là trong niềng răng Invisalign – một trong những phương pháp nha khoa được rất nhiều khách hàng tin tưởng lựa chọn Nha Khoa Kim để thực hiện.','2023-03-04 00:00:00','2023-03-04 00:00:00',4,0,'https://nhakhoakim.com/wp-content/uploads/2021/12/700x500_TraoMay-01.jpg'),(9,2,'Những con số cực ấn tượng của Hành trình răng hạnh phúc tháng 10','Khởi hành vào đầu tháng 10, tính đến thời điểm hiện tại, “Hành trình răng hạnh phúc” đã đi qua nhiều địa điểm khác nhau ở TP.HCM và Bình Dương. Tại mỗi điểm đến, Nha Khoa HNT và Hành trình răng hạnh phúc đều nhận được sự quan tâm và hưởng ứng nhiệt liệt đến từ các bạn học sinh, sinh viên lẫn các anh chị công nhân. ','Nhìn lại chặng đường chỉ trong một tháng qua, “Hành trình răng hạnh phúc” ghi nhận những con số vô cùng ấn tượng, với:','2023-03-04 00:00:00','2023-03-04 00:00:00',4,0,'https://nhakhoakim.com/wp-content/uploads/2022/10/NKK_web-dental-tour-DH-BINH-DUONG-06.jpg'),(10,3,'Bàn chải kẽ răng là gì? Vì sao nên dùng khi niềng răng','Chăm sóc và vệ sinh răng miệng là vấn đề khá quan trọng đối với người niềng răng. Bởi nếu răng miệng không được sạch sẽ không chỉ gây ra các bệnh lý nha khoa nguy hiểm mà còn làm ảnh hưởng đến quá trình niềng.  Bên cạnh bàn chải thường thì các bác sĩ cũng khuyến khích người niềng răng sử dụng thêm bàn chải kẽ để làm sạch hiệu quả hơn. Vậy bàn chải kẽ răng là gì? Vì..','Bàn chải kẽ răng là gì?','2023-03-04 00:00:00','2023-03-04 00:00:00',4,1,'https://nhakhoakim.com/wp-content/uploads/2023/07/Ban-chai-ke-2.png'),(11,3,'Siết răng khi niềng là gì? Lưu ý và cách giảm đau nhanh chóng','Niềng răng là phương pháp chỉnh nha được nhiều người lựa chọn, đặc biệt là giới trẻ để điều chỉnh các vấn đề về răng như răng mọc không đều, mọc lệch lạc, răng hô, móm, thưa,…Thường thì khi được các bác sĩ tư vấn niềng răng, bạn sẽ nghe nhắc đến thao tác siết răng khi niềng. Vậy siết răng khi niềng là gì? Lưu ý và cách giảm đau nhanh chóng. Cùng Nha Khoa Kim tìm hiểu rõ hơn thông qua bài viết dưới đây nhé!','Siết răng khi niềng là gì?','2023-03-04 00:00:00','2023-03-04 00:00:00',4,1,'https://nhakhoakim.com/wp-content/uploads/2023/07/Siet-rang-khi-nieng-4.png'),(12,3,'Kiêng đánh răng sau sinh là đúng hay sai?','Sau khi sinh, các chị em thường hay thực hiện kiêng cữ nhiều điều. Không chỉ kiêng gió kiêng nước mà thậm chí còn kiêng luôn cả việc đánh răng. Vì theo nhiều người, có như mới bảo vệ hàm răng được chắc khỏe, không bị ế buốt, yếu đi và dễ rụng khi về già. Vậy kiêng đánh răng sau sinh là đúng hay sai? Nếu bạn cũng có thắc mắc này thì nhất định không được bỏ qua bài viết dưới đây của Nha Khoa Kim.','Kiêng đánh răng sau sinh là đúng hay sai?','2023-03-04 00:00:00','2023-03-04 00:00:00',4,1,'https://nhakhoakim.com/wp-content/uploads/2023/07/Kieng-danh-rang-sau-sinh-2.png'),(13,3,'Thuốc trị viêm tủy răng tại nhà và nên kiêng ăn gì?','Viêm tủy răng là một vấn đề phổ biến, không chỉ gây ra cảm giác đau nhức mà còn ảnh hưởng đến chất lượng cuộc sống hàng ngày. Không chỉ việc sử dụng thuốc mà chế độ ăn uống cũng đóng vai trò quan trọng trong quá trình điều trị. Cùng Nha khoa Kim sẽ tìm hiểu về thuốc trị viêm tủy răng tại nhà và những thực phẩm nên kiêng ăn để đạt được kết quả chữa trị tốt nhất nhé!','Dưới đây là một số lựa chọn thuốc có thể được sử dụng để giảm đau tạm thời cho viêm tủy răng:','2023-03-04 00:00:00','2023-03-04 00:00:00',4,1,'https://nhakhoakim.com/wp-content/uploads/2023/07/Tri-viem-tuy-rang-tai-nha.png'),(14,3,'Nấm miệng ở trẻ nhỏ và người lớn là bệnh gì? Cách điều trị ra sao','Nấm miệng, một bệnh lý phổ biến ở cả trẻ nhỏ và người lớn. Tình trạng này thường gây ra nhiều bất tiện và ảnh hưởng không nhỏ đến chất lượng cuộc sống. Cùng Nha khoa Kim tìm hiểu về bệnh nấm miệng, cách điều trị hiệu quả để đảm bảo sức khỏe và thoải mái ăn uống nhé!','Nấm miệng ở trẻ nhỏ và người lớn là bệnh gì?','2023-03-04 00:00:00','2023-03-04 00:00:00',5,1,'https://nhakhoakim.com/wp-content/uploads/2023/07/Nam-mieng-la-benh-gi.png'),(15,4,'U xương hàm răng: Nguyên nhân và cách điều trị','U xương hàm răng là một tình trạng khá phổ biến ở vùng răng hàm mặt, thường xuất hiện một cách bất ngờ và không rõ ràng. Cùng Nha khoa kim tìm hiểu về nguyên nhân và cách điều trị cho bệnh u xương hàm răng nhé! U xương hàm răng là bệnh gì? U xương hàm răng hay u xương chân răng là bệnh lý xuất phát từ xương hàm hoặc các mô mềm trong miệng và khu vực mặt. Loại...','U xương hàm răng là bệnh gì?','2023-03-04 00:00:00','2023-03-04 00:00:00',5,1,'https://nhakhoakim.com/wp-content/uploads/2023/07/Dieu-tri-u-xuong-ham-rang.png'),(16,4,'Nên đánh răng sau ăn bao lâu thì tốt nhất','Đánh răng vào buổi sáng, tối và sau khi ăn là thói quen vô cùng cần thiết nếu bạn muốn sở hữu một hàm răng chắc khỏe, trắng sáng và sạch sẽ. Tuy nhiên, để mang lại hiệu quả tốt thì việc lựa chọn thời điểm đánh răng là rất quan trọng, nhất là trường hợp đánh răng sau khi ăn. Vậy nên đánh răng sau ăn bao lâu thì tốt nhất? Bài viết dưới đây của Nha Khoa Kim sẽ giúp bạn trả lời câu hỏi này.','Có nên đánh răng sau khi ăn hay không?','2023-03-04 00:00:00','2023-03-04 00:00:00',5,1,'https://nhakhoakim.com/wp-content/uploads/2023/07/Nen-danh-rang-sau-an-bao-lau-2.png'),(17,4,'Uống nhiều nước đá có bị sâu răng không?','Chế độ ăn uống ảnh hưởng rất nhiều đến sức khỏe răng miệng. Bạn có biết, không chỉ có thực phẩm ngọt, cà phê mà thậm chí ngay cả uống nước đá cũng khiến cho răng bạn bị tổn thương. Liên quan đến vấn đề này, trong thời gian gần đây Nha Khoa Kim nhận được rất nhiều câu hỏi về việc uống nhiều nước đá có bị sâu răng không? Để có cho mình câu trả lời chính xác nhất, mời bạn theo dõi ngay bài viết dưới đây.','Lợi ích khi sử dụng đá trong đời sống hàng ngày','2023-03-04 00:00:00','2023-03-04 00:00:00',5,1,'https://nhakhoakim.com/wp-content/uploads/2023/07/Nuoc-da-1.png'),(18,4,'Hiện tượng rát lưỡi là bệnh gì? Nguyên nhân và cách trị','Rát lưỡi là một vấn đề phổ biến trong lĩnh vực sức khỏe miệng mà nhiều người gặp phải. Hiện tượng có thể gây ra không chỉ sự khó chịu mà còn ảnh hưởng đáng kể đến chất lượng cuộc sống hàng ngày. Cùng Nha khoa Kim khám phá sâu hơn về hiện tượng rát lưỡi là bệnh gì, các nguyên nhân cũng như phương pháp điều trị nhé! ','Triệu chứng nhận biết bệnh rát lưỡi','2023-03-04 00:00:00','2023-03-04 00:00:00',5,1,'https://nhakhoakim.com/wp-content/uploads/2023/07/Rat-luoi.png'),(19,4,'Cách phân biệt nhiệt miệng và sùi mào gà ở miệng?','Nhiều người thường hay nhầm lẫn nhiệt miệng và sùi mào gà ở vùng miệng vì 2 bệnh lý này có triệu chứng tương đối giống nhau. Tuy nhiên, so với nhiệt miệng một tình trạng viêm loét niêm mạc phổ biến, thường gặp ở nhiều người và đa số sẽ tự khỏi sau vài ngày thì sùi mào gà lại là một căn bệnh truyền nhiễm nguy hiểm, nếu không được điều trị sớm sẽ ảnh hưởng nghiêm trọng đến sức khỏe. Vậy làm thế nào để biết mình đã mắc bệnh để điều trị? Theo dõi ngay bài viết dưới đây của Nha Khoa Kim để biết cách phân biệt nhiệt miệng và sùi mào gà ở miệng?','Nhiệt miệng và sùi mào gà ở miệng là gì?','2023-03-04 00:00:00','2023-03-04 00:00:00',5,1,'https://nhakhoakim.com/wp-content/uploads/2023/07/sui-mao-ga-o-mieng.png'),(20,4,'Bé bị rộp trắng trong miệng là bệnh gì? Cách điều trị hiệu quả','Bé bị rộp trắng trong miệng thường khiến nhiều phụ huynh cảm thấy lo lắng, đặc biệt là những ai chỉ mới làm bố mẹ lần đầu. Đây có thể là dấu hiệu của bệnh nấm miệng (tưa lưỡi). Hoặc nó chỉ đơn giản là cặn sữa còn đọng lại. Vậy bé bị rộp trắng trong miệng là bệnh gì? Cách điều trị hiệu quả ra sao? Tất cả sẽ được giải đáp trong bài viết dưới đây của Nha Khoa...','Tại sao trẻ bị rộp trắng trong miệng?','2023-03-04 00:00:00','2023-03-04 00:00:00',5,1,'https://nhakhoakim.com/wp-content/uploads/2023/07/Be-bi-rop-trang-trong-mieng-la-benh-gi.png');
/*!40000 ALTER TABLE `blogs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `booking`
--

DROP TABLE IF EXISTS `booking`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `booking` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `phone` int NOT NULL,
  `gender` bit(1) DEFAULT NULL,
  `age` int NOT NULL,
  `account_id` bigint NOT NULL,
  `service_id` bigint NOT NULL,
  `service_type_id` bigint DEFAULT NULL,
  `doctor_id` bigint DEFAULT NULL,
  `staff_id` bigint DEFAULT NULL,
  `date` date NOT NULL,
  `time` time NOT NULL,
  `decription` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci,
  `status` int NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `booking`
--

LOCK TABLES `booking` WRITE;
/*!40000 ALTER TABLE `booking` DISABLE KEYS */;
INSERT INTO `booking` VALUES (1,'Nguyen Thi Huyen',984118075,_binary '\0',23,22,1,1,17,6,'2023-07-03','07:00:00','Tôi muốn làm răng sứ',0,'2023-07-26 08:01:30','2023-07-26 08:01:30'),(2,'Nguyen Thị Huyền',984118075,_binary '\0',20,22,2,1,17,6,'2023-07-26','11:00:00','Tôi muốn làm dịch vụ này',0,'2023-07-26 08:02:30','2023-07-26 08:02:30'),(3,'Lưu Văn Ba',984118765,_binary '',40,27,4,2,17,7,'2023-07-20','10:00:00','Tôi muốn làm răng sứ',0,'2023-07-26 08:24:56','2023-07-26 08:24:56'),(4,'Khương Văn Thảo',355196361,_binary '\0',38,27,6,1,17,7,'2023-06-06','16:00:00','Tôi đau răng muốn nhổ răng khôn',2,'2023-07-26 08:26:31','2023-07-26 08:26:31'),(5,'Nguyen Van A',984118075,_binary '',50,27,7,1,16,8,'2023-07-05','14:00:00','tôi muốn khám răng',2,'2023-07-26 08:27:36','2023-07-26 08:27:36'),(6,'Phan Thị Trang',355196362,_binary '\0',67,23,8,2,19,NULL,'2023-07-26','16:00:00','Tôi bị sâu răng',0,'2023-07-26 09:15:40','2023-07-26 09:15:40'),(7,'Phan Văn Ba',653421345,_binary '',50,23,5,3,20,9,'2023-07-10','15:00:00','Răng tôi bị ố vàng, muốn tẩy trắng lại',0,'2023-07-26 09:17:49','2023-07-26 09:17:49'),(8,'Đặng Khánh Linh',123454321,_binary '\0',30,22,10,2,21,9,'2023-07-05','15:00:00','qehwgfuivqb',0,'2023-07-26 09:28:46','2023-07-26 09:28:46'),(9,'Nguyen Thị Huyền',984118075,_binary '\0',20,22,11,1,21,9,'2023-07-30','15:00:00','Tôi muốn khám răng tổng quát',0,'2023-07-26 09:29:49','2023-07-26 09:29:49'),(10,'Trịnh Tứ Bảo',984128087,_binary '',24,24,6,3,21,NULL,'2023-07-20','07:00:00','Tôi muốn nhổ răng',2,'2023-07-26 09:47:34','2023-07-26 09:47:34'),(11,'Trịnh Tứ Bảo',366256134,_binary '',20,24,5,3,20,NULL,'2023-07-21','15:00:00','Tôi muốn đi tẩy trăng răng vì nó bị ố vàng',0,'2023-07-26 09:49:02','2023-07-26 09:49:02'),(12,'Nguyễn Thị Hải Diệp',984556674,_binary '\0',20,24,10,1,17,NULL,'2023-07-17','16:00:00','Đặt lịch khám cho vợ',2,'2023-07-26 09:51:30','2023-07-26 09:51:30');
/*!40000 ALTER TABLE `booking` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `booking_result`
--

DROP TABLE IF EXISTS `booking_result`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `booking_result` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `booking_id` bigint NOT NULL,
  `result` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `booking_result`
--

LOCK TABLES `booking_result` WRITE;
/*!40000 ALTER TABLE `booking_result` DISABLE KEYS */;
INSERT INTO `booking_result` VALUES (1,1,NULL,'2023-07-26 08:01:30','2023-07-26 08:01:30'),(2,2,NULL,'2023-07-26 08:02:30','2023-07-26 08:02:30'),(3,3,NULL,'2023-07-26 08:24:56','2023-07-26 08:24:56'),(4,4,NULL,'2023-07-26 08:26:31','2023-07-26 08:26:31'),(5,5,NULL,'2023-07-26 08:27:36','2023-07-26 08:27:36'),(6,6,NULL,'2023-07-26 09:15:40','2023-07-26 09:15:40'),(7,7,NULL,'2023-07-26 09:17:49','2023-07-26 09:17:49'),(8,8,NULL,'2023-07-26 09:28:46','2023-07-26 09:28:46'),(9,9,NULL,'2023-07-26 09:29:49','2023-07-26 09:29:49'),(10,10,'','2023-07-26 09:47:34','2023-07-26 09:59:05'),(11,11,NULL,'2023-07-26 09:49:02','2023-07-26 09:49:02'),(12,12,NULL,'2023-07-26 09:51:30','2023-07-26 09:51:30');
/*!40000 ALTER TABLE `booking_result` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `category_blog`
--

DROP TABLE IF EXISTS `category_blog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `category_blog` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `category_blog`
--

LOCK TABLES `category_blog` WRITE;
/*!40000 ALTER TABLE `category_blog` DISABLE KEYS */;
INSERT INTO `category_blog` VALUES (1,'Hoạt động Nha khoa HNT','2023-03-03 00:00:00','2023-03-03 00:00:00'),(2,'Hợp tác chiến lược','2023-03-03 00:00:00','2023-03-03 00:00:00'),(3,'Tin tức & Sự kiện','2023-03-03 00:00:00','2023-03-03 00:00:00'),(4,'Kiến thức răng miệng','2023-03-03 00:00:00','2023-03-03 00:00:00');
/*!40000 ALTER TABLE `category_blog` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `doctor_of_rank`
--

DROP TABLE IF EXISTS `doctor_of_rank`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `doctor_of_rank` (
  `rank_id` bigint NOT NULL,
  `type_id` bigint NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `doctor_of_rank`
--

LOCK TABLES `doctor_of_rank` WRITE;
/*!40000 ALTER TABLE `doctor_of_rank` DISABLE KEYS */;
INSERT INTO `doctor_of_rank` VALUES (1,1),(2,1),(2,2),(3,3),(1,4),(2,4);
/*!40000 ALTER TABLE `doctor_of_rank` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `doctor_rank`
--

DROP TABLE IF EXISTS `doctor_rank`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `doctor_rank` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `doctor_rank`
--

LOCK TABLES `doctor_rank` WRITE;
/*!40000 ALTER TABLE `doctor_rank` DISABLE KEYS */;
INSERT INTO `doctor_rank` VALUES (1,'Rank 1','2023-07-24 00:00:00','2023-07-24 00:00:00'),(2,'Rank 2','2023-07-24 00:00:00','2023-07-24 00:00:00'),(3,'Rank 3','2023-07-24 00:00:00','2023-07-24 00:00:00');
/*!40000 ALTER TABLE `doctor_rank` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `doctors`
--

DROP TABLE IF EXISTS `doctors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `doctors` (
  `id` bigint NOT NULL,
  `full_name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `dob` date DEFAULT NULL,
  `gender` tinyint(1) DEFAULT NULL,
  `phone` int DEFAULT NULL,
  `address` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci,
  `position` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `fee` double DEFAULT NULL,
  `description` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci,
  `rank_id` bigint DEFAULT NULL,
  `status` tinyint DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `image` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `doctors`
--

LOCK TABLES `doctors` WRITE;
/*!40000 ALTER TABLE `doctors` DISABLE KEYS */;
INSERT INTO `doctors` VALUES (16,'Phan Thanh An','2000-10-02',1,984118075,'Nghệ An','Phó Chủ tịch Hội đồng Khoa',1,'Bác sĩ nha khoa này đã có hơn 20 năm kinh nghiệm trong lĩnh vực nha khoa, là một chuyên gia hàng đầu với kiến thức đa dạng và sâu sắc về điều trị răng miệng',1,1,'2023-07-24 00:00:00','2023-07-24 00:00:00','https://www.hanhphuchospital.com/wp-content/uploads/2020/01/Bs-Nguyen-Thi-Trang-Khanh-Linh-1-277x327.jpg'),(17,'Nguyễn Thiện An','1989-10-01',1,984118475,'Hà Nọi','Phó chủ tịch Hội đồng chuyên khoa Nhi',1,'Với khả năng phân tích và chuẩn đoán tinh tế, bác sĩ này đã giúp hàng trăm bệnh nhân phục hồi và duy trì sức khỏe răng miệng tốt.',2,1,'2023-07-24 00:00:00','2023-07-24 00:00:00','https://www.hanhphuchospital.com/wp-content/uploads/2020/01/Bs-Tieu-Thanh-Lieu-277x327.jpg'),(18,'Phan Đăng Trường','1987-09-08',1,984118075,'Hà Nội','Bác sĩ Nhi khoa hơn 25 năm kinh nghiệm',1,'Bác sĩ đã từng làm việc với nhiều trường hợp phức tạp như mắc cài implant, nha chu, tẩy trắng răng và điều trị những tình trạng nha khoa nghiêm trọng.',1,1,'2023-07-24 00:00:00','2023-07-24 00:00:00','https://www.hanhphuchospital.com/wp-content/uploads/2019/12/Bs-Nguyen-Van-Nhan-277x327.jpg'),(19,'Nguyễn Đức Mạnh','1978-10-05',0,984118475,'Quảng Ninh','Thư ký Hội đồng Nhi Sơ sinh & Hồi sức Sơ sinh',1,'Tinh thần tận tâm và chăm sóc bệnh nhân luôn được đặt lên hàng đầu. Bác sĩ dành thời gian lắng nghe và tư vấn kỹ càng để đảm bảo bệnh nhân hiểu rõ về tình trạng sức khỏe răng miệng và quy trình điều trị.',2,0,'2023-07-24 00:00:00','2023-07-24 00:00:00','https://www.hanhphuchospital.com/wp-content/uploads/2019/12/Bs-Trinh-Minh-Duc-277x327.jpg'),(20,'Nguyễn Hoàng Huy','1979-10-04',0,984318075,'Hà Nội','Giám Đốc Trung tâm Hỗ trợ nha khoa',1,'Bác sĩ nha khoa này luôn cập nhật công nghệ và kỹ thuật mới nhất để đem đến những phương pháp điều trị hiện đại và hiệu quả.',3,0,'2023-07-24 00:00:00','2023-07-24 00:00:00','https://www.hanhphuchospital.com/wp-content/uploads/2021/03/Bs-Dang-Thanh-Binh-Copy.jpg'),(21,'Phạm Cao Đức Minh','2000-10-03',1,983118075,'Hà Nội','Trưởng bộ phận lâm sàng',1,'Sự tận tụy và cam kết của bác sĩ đã tạo nên một lượng lớn bệnh nhân trung thành và hài lòng với kết quả điều trị.',3,1,'2023-07-24 00:00:00','2023-07-24 00:00:00','https://www.hanhphuchospital.com/wp-content/uploads/2019/12/Bs-Bui-Long-Than-277x327.jpg');
/*!40000 ALTER TABLE `doctors` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `employees`
--

DROP TABLE IF EXISTS `employees`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `employees` (
  `id` bigint NOT NULL,
  `full_name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `dob` date DEFAULT NULL,
  `gender` tinyint(1) DEFAULT NULL,
  `phone` int DEFAULT NULL,
  `address` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci,
  `salary` double DEFAULT NULL,
  `status` tinyint(1) DEFAULT NULL,
  `description` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `employees`
--

LOCK TABLES `employees` WRITE;
/*!40000 ALTER TABLE `employees` DISABLE KEYS */;
INSERT INTO `employees` VALUES (1,'Nguyễn Thị Huyền','1980-03-02',0,984118973,'Hà Nội',100000000,1,'Admin','2023-01-01 00:00:00','2023-01-01 00:00:00'),(2,'Nguyễn Văn Thanh','1972-10-09',0,984118976,'Hà Nội',200000000,1,'Admin','2023-01-01 00:00:00','2023-01-01 00:00:00'),(3,'Bùi Thùy Linh','1990-01-01',0,984318075,'Hà Nội',1000000,1,'Thực tập sinh','2023-01-01 00:00:00','2023-01-01 00:00:00'),(4,'Bùi Thị My','1990-01-01',0,984118075,'Hà Nội',5000000,1,NULL,'2023-01-01 00:00:00','2023-01-01 00:00:00'),(5,'Nguyễn Thị Huyền Trang','1990-01-01',0,984218075,'Hà Nội',5000000,1,NULL,'2023-01-01 00:00:00','2023-01-01 00:00:00'),(6,'Trần Quốc Khánh','1990-01-01',1,984418075,'Hải Phòng',5000000,1,NULL,'2023-01-01 00:00:00','2023-01-01 00:00:00'),(7,'Trần Ninh Tuấn','1990-01-01',1,943118075,'Nghệ An',5000000,1,'Thực tập sinh','2023-01-01 00:00:00','2023-01-01 00:00:00'),(8,'Phạm Quang Khang','1990-01-01',1,983718075,'Thanh Hóa',5000000,1,NULL,'2023-01-01 00:00:00','2023-01-01 00:00:00'),(9,'Tạ Đình Tiến','1990-01-01',1,984898075,'Hà Nội',5000000,1,NULL,'2023-01-01 00:00:00','2023-01-01 00:00:00'),(10,'Lưu Quốc Trung','1990-01-01',1,984658075,'Hà Nội',2000000,1,'Thực tập sinh','2023-01-01 00:00:00','2023-01-01 00:00:00'),(11,'Nguyễn Tiến Đoàn','1990-01-01',1,984128075,'Hà Nội',5000000,1,NULL,'2023-01-01 00:00:00','2023-01-01 00:00:00'),(12,'Lương Văn Thảo','1990-01-01',1,982318075,'Hà Nội',3000000,1,'Thực tập sinh','2023-01-01 00:00:00','2023-01-01 00:00:00'),(13,'Nguyễn Tiến Huy','1990-01-01',1,983518075,'Nam Định',5000000,1,NULL,'2023-01-01 00:00:00','2023-01-01 00:00:00'),(14,'Nguyễn Thị Khánh Thương','1990-01-01',0,985618075,'Thái Bình',5000000,1,NULL,'2023-01-01 00:00:00','2023-01-01 00:00:00'),(15,'Nguyễn Thùy Liên','1990-01-01',0,988718075,'Hà Nội',5000000,1,NULL,'2023-01-01 00:00:00','2023-01-01 00:00:00');
/*!40000 ALTER TABLE `employees` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `feedback`
--

DROP TABLE IF EXISTS `feedback`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `feedback` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `booking_id` bigint NOT NULL,
  `service_id` bigint DEFAULT NULL,
  `doctor_id` bigint DEFAULT NULL,
  `star` int DEFAULT NULL,
  `description` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `is_show` bit(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `feedback`
--

LOCK TABLES `feedback` WRITE;
/*!40000 ALTER TABLE `feedback` DISABLE KEYS */;
INSERT INTO `feedback` VALUES (1,1,1,NULL,5,'Dịch vụ tốt, chăm sóc chuyên nghiệp','2023-07-26 02:32:38','2023-07-26 02:32:38',_binary ''),(2,9,11,NULL,4,'bác sĩ nhiệt tình, ân cần','2023-07-26 02:34:51','2023-07-26 02:34:51',_binary '');
/*!40000 ALTER TABLE `feedback` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `patients`
--

DROP TABLE IF EXISTS `patients`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `patients` (
  `id` bigint NOT NULL,
  `full_name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `dob` date DEFAULT NULL,
  `gender` tinyint(1) DEFAULT NULL,
  `phone` int DEFAULT NULL,
  `address` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci,
  `description` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci,
  `image` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `status` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `patients`
--

LOCK TABLES `patients` WRITE;
/*!40000 ALTER TABLE `patients` DISABLE KEYS */;
INSERT INTO `patients` VALUES (22,'Nguyễn Thu Huyền','2000-01-01',1,984118098,'Nghệ An','',NULL,'2023-07-26 07:58:03','2023-07-26 07:58:03',NULL),(23,'Nguyễn Minh Hùng','2000-01-03',1,355106361,'Hà Nội',NULL,NULL,'2023-01-01 00:00:00','2023-01-01 00:00:00',NULL),(24,'Nguyễn Văn Bảo','1999-01-03',1,975188388,'Hà Nội',NULL,NULL,'2023-01-01 00:00:00','2023-01-01 00:00:00',NULL),(25,'Đinh Văn Mạnh','1980-04-05',1,976288456,'Hà Nội',NULL,NULL,'2023-01-01 00:00:00','2023-01-01 00:00:00',NULL),(26,'Bùi Viết Tuấn','1989-10-10',1,986276435,'Hà Nội',NULL,NULL,'2023-01-01 00:00:00','2023-01-01 00:00:00',NULL),(27,'Khương Thị Mơ','1873-02-02',0,984117654,'Hà Nội',NULL,NULL,'2023-01-01 00:00:00','2023-01-01 00:00:00',NULL);
/*!40000 ALTER TABLE `patients` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payment`
--

DROP TABLE IF EXISTS `payment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `payment` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `account_id` bigint NOT NULL,
  `booking_id` bigint NOT NULL,
  `fee` double DEFAULT NULL,
  `status` bit(1) DEFAULT NULL,
  `type` int NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payment`
--

LOCK TABLES `payment` WRITE;
/*!40000 ALTER TABLE `payment` DISABLE KEYS */;
INSERT INTO `payment` VALUES (1,1,1,500000,_binary '\0',1,'2023-07-26 08:01:30','2023-07-26 08:01:30'),(2,1,2,8000000,_binary '\0',0,'2023-07-26 08:02:30','2023-07-26 08:02:30'),(3,1,3,900000,_binary '\0',1,'2023-07-26 08:24:56','2023-07-26 08:24:56'),(4,1,4,1500000,_binary '\0',1,'2023-07-26 08:26:31','2023-07-26 08:26:31'),(5,1,5,750000,_binary '\0',0,'2023-07-26 08:27:36','2023-07-26 08:27:36'),(6,1,6,600000,_binary '\0',1,'2023-07-26 09:15:40','2023-07-26 09:15:40'),(7,1,7,5000000,_binary '',1,'2023-07-26 09:17:49','2023-07-26 09:17:49'),(8,1,8,900000,_binary '\0',1,'2023-07-26 09:28:46','2023-07-26 09:28:46'),(9,1,9,300000,_binary '',0,'2023-07-26 16:29:49','2023-07-26 09:30:41'),(10,1,10,4000000,_binary '\0',1,'2023-07-26 09:47:34','2023-07-26 09:47:34'),(11,1,11,5000000,_binary '\0',1,'2023-07-26 09:49:02','2023-07-26 09:49:02'),(12,1,12,400000,_binary '',0,'2023-07-26 09:51:30','2023-07-26 09:51:30');
/*!40000 ALTER TABLE `payment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `service`
--

DROP TABLE IF EXISTS `service`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `service` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `description` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `image` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `created_at` datetime NOT NULL,
  `updated_at` datetime DEFAULT NULL,
  `status` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `service`
--

LOCK TABLES `service` WRITE;
/*!40000 ALTER TABLE `service` DISABLE KEYS */;
INSERT INTO `service` VALUES (1,'Bọc răng sứ','Bọc răng sứ (phục hình cố định răng sứ) là sử dụng răng sứ được làm hoàn toàn từ sứ hoặc sứ kết hợp cùng kim loại để chụp lên phần răng khiếm khuyết hoặc hư tổn để tái tạo hình dáng, kích thước và màu sắc như răng thật.','https://nhakhoakim.com/wp-content/uploads/2019/08/Mau-rang-su-Nha-Khoa-Kim-scaled-768x478.jpg','2022-01-01 00:00:00','2023-07-26 08:44:15',1),(2,'Cấy ghép implant','Cấy ghép Implant – Giải pháp giúp phục hồi răng bị mất hoàn hảo nhất','https://nhakhoakim.com/wp-content/uploads/2018/01/cay-ghep-implant-nha-khoa-kim-2.jpg','2022-01-01 00:00:00','2022-01-01 00:00:00',1),(3,'Niềng răng thẩm mỹ','Niềng răng là phương pháp sử dụng khí cụ chuyên dụng được gắn cố định hoặc tháo lắp trên răng để giúp dịch chuyển và sắp xếp răng về đúng vị trí. Từ đó, mang lại cho khách hàng một hàm răng đều, đẹp, đảm bảo chức năng ăn nhai, khớp cắn đúng…','https://nhakhoakim.com/wp-content/uploads/2016/11/nieng-rang-tham-my-2-1.jpg','2022-01-01 00:00:00','2022-01-01 00:00:00',1),(4,'Mặt dán sứ Veneer','Răng sứ Veneer là mặt dán sứ bọc dùng để bọc bên ngoài bề mặt răng nhằm che lấp các khuyết điểm khi răng bị tổn thương cấu trúc hoặc xỉn màu, ố vàng và đem đến cho khách hàng một hàm răng đều, đẹp, trắng sáng bền vững theo thời gian.','https://nhakhoakim.com/wp-content/uploads/2016/11/veneers-turkey.jpg','2022-01-01 00:00:00','2022-01-01 00:00:00',1),(5,'Tẩy trăng răng','Tẩy trắng răng là phương pháp dùng các hợp chất kết hợp với năng lượng ánh sáng sẽ tạo ra phản ứng oxy hóa cắt đứt các chuỗi phân tử màu trong ngà răng, giúp răng trắng sáng hơn so với màu răng ban đầu mà không làm tổn hại bề mặt răng hay bất kỳ yếu tố nào trong răng.','https://nhakhoakim.com/wp-content/uploads/2022/08/tay-trang-rang-hieu-qua-Nha-Khoa-Kim-1-768x548.jpg','2022-01-01 00:00:00','2022-01-01 00:00:00',1),(6,'Nhổ răng khôn','Răng khôn hay còn được gọi là răng số 8, là răng hàm lớn thứ 3 xuất hiện cuối cùng trong hàm và thường mọc ở người có độ tuổi từ 17 – 25. Tất cả mọi người đều có 4 cái răng khôn, bao gồm 2 cái hàm dưới và 2 cái hàm trên.','https://nhakhoakim.com/wp-content/uploads/2022/08/nho-rang-khon-an-toan-tai-Nha-Khoa-Kim-1-768x548.jpg','2022-01-01 00:00:00','2022-01-01 00:00:00',1),(7,'Bệnh lý nha chu','Bệnh nha chu là một bệnh nhiễm trùng nướu làm tổn thương mô mềm và phá hủy xương xung quanh răng. Trường hợp nhiễm trùng trở nên nghiêm trọng có thể khiến răng bị lỏng hoặc dẫn đến mất răng.','https://nhakhoakim.com/wp-content/uploads/2022/08/han-tram-rang-tai-Nha-Khoa-Kim-1-768x549.jpg','2022-01-01 00:00:00','2022-01-01 00:00:00',1),(8,'Điều trị tủy','Nguyên nhân của viêm tủy răng? ','https://nhakhoakim.com/wp-content/uploads/2022/08/dieu-tri-tuy-rang-an-toan-tai-Nha-Khoa-Kim-1-768x548.jpg','2022-01-01 00:00:00','2022-01-01 00:00:00',1),(9,'Hàm trám răng','Hàn trám răng là kỹ thuật mà bác sĩ sẽ sử dụng vật liệu trám bít để khôi phục lại hình dáng và chức năng của răng. Phương pháp này được sử dụng phổ biến trong nha khoa bởi mang lại ý nghĩa cả về thẩm mỹ lẫn điều trị và phòng ngừa bệnh lý răng miệng.','https://nhakhoakim.com/wp-content/uploads/2022/08/han-tram-rang-tai-Nha-Khoa-Kim-5-768x549.jpg','2022-01-01 00:00:00','2022-01-01 00:00:00',1),(10,'Chăm sóc răng miệng cho thai phụ','Vì sao phải chăm sóc răng miệng cho phụ nữ mang thai?','https://nhakhoakim.com/wp-content/uploads/2018/10/123rf_46388751_super.jpg','2022-01-01 00:00:00','2022-01-01 00:00:00',1),(11,'Khám tổng quát','Khám răng định kỳ có lợi ích gì?','http://nhakhoaquocte.net.vn/public/upload/images/kham-rang-dinh-ky(1).jpg','2022-01-01 00:00:00','2022-01-01 00:00:00',1);
/*!40000 ALTER TABLE `service` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `service_doctor`
--

DROP TABLE IF EXISTS `service_doctor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `service_doctor` (
  `id_doctor` bigint NOT NULL,
  `id_service` bigint NOT NULL,
  PRIMARY KEY (`id_doctor`,`id_service`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `service_doctor`
--

LOCK TABLES `service_doctor` WRITE;
/*!40000 ALTER TABLE `service_doctor` DISABLE KEYS */;
INSERT INTO `service_doctor` VALUES (16,1),(16,2),(16,3),(16,4),(16,6),(16,7),(16,11),(17,1),(17,2),(17,3),(17,4),(17,6),(17,7),(17,8),(17,10),(18,3),(18,4),(18,6),(18,7),(18,9),(18,10),(18,11),(19,1),(19,2),(19,7),(19,8),(19,9),(19,10),(19,11),(20,4),(20,5),(20,8),(20,11),(21,4),(21,6),(21,8),(21,11);
/*!40000 ALTER TABLE `service_doctor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `service_fee`
--

DROP TABLE IF EXISTS `service_fee`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `service_fee` (
  `service_id` bigint NOT NULL,
  `service_type` bigint NOT NULL,
  `fee` double NOT NULL,
  PRIMARY KEY (`service_id`,`service_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `service_fee`
--

LOCK TABLES `service_fee` WRITE;
/*!40000 ALTER TABLE `service_fee` DISABLE KEYS */;
INSERT INTO `service_fee` VALUES (1,1,500000),(1,2,700000),(2,1,8000000),(2,2,10000000),(3,1,3000000),(3,2,3500000),(4,1,600000),(4,2,900000),(4,3,3000000),(5,3,5000000),(6,1,1500000),(6,2,2500000),(6,3,4000000),(7,1,750000),(7,2,950000),(8,2,600000),(8,3,730000),(9,1,600000),(9,2,1000000),(10,1,400000),(10,2,900000),(11,1,300000),(11,2,500000),(11,3,900000);
/*!40000 ALTER TABLE `service_fee` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `service_type`
--

DROP TABLE IF EXISTS `service_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `service_type` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `description` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `service_type`
--

LOCK TABLES `service_type` WRITE;
/*!40000 ALTER TABLE `service_type` DISABLE KEYS */;
INSERT INTO `service_type` VALUES (1,'THƯỜNG','Dịch vụ thường là các gói dịch vụ cơ bản được cung cấp cho khách hàng một cách thông thường và tiêu chuẩn. Trong các gói dịch vụ này, khách hàng được đảm bảo những dịch vụ cơ bản và tiêu chuẩn của doanh nghiệp hoặc tổ chức. Thông thường, giá cả của các dịch vụ này thấp hơn so với các gói dịch vụ VIP.','2023-07-24 00:00:00','2023-07-24 00:00:00'),(2,'VIP1','Dịch vụ VIP 1 là một bước tiến lên phía trên so với dịch vụ thường. Trong gói dịch vụ này, khách hàng được hưởng nhiều ưu đãi và tiện ích cao cấp hơn. Điều này có thể bao gồm mức độ chăm sóc và hỗ trợ cá nhân cao hơn, đặc quyền dành riêng cho khách hàng VIP 1, và tiếp cận các sản phẩm, dịch vụ hoặc sự kiện độc quyền. Giá cả của dịch vụ VIP 1 thường cao hơn so với dịch vụ thường, nhưng khách hàng được đảm bảo sự đáng giá tương xứng với chi phí.','2023-07-24 00:00:00','2023-07-24 00:00:00'),(3,'VIP2','Dịch vụ VIP 2 là dịch vụ cao cấp nhất và đa dạng nhất trong số ba loại dịch vụ. Khách hàng VIP 2 được hưởng những ưu đãi và tiện ích đặc biệt, tiếp cận những sản phẩm, dịch vụ và trải nghiệm độc nhất vô nhị. Gói dịch vụ này thường chú trọng đến việc tạo ra trải nghiệm tùy chỉnh và cá nhân hóa cao cho khách hàng. Giá cả của dịch vụ VIP 2 thường rất cao, tuy nhiên, nó đảm bảo mang đến những tiện ích tối đa và sự hài lòng tuyệt đối cho khách hàng VIP 2.','2023-07-24 00:00:00','2023-07-24 00:00:00');
/*!40000 ALTER TABLE `service_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `verification`
--

DROP TABLE IF EXISTS `verification`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `verification` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `life_time` int DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `verification`
--

LOCK TABLES `verification` WRITE;
/*!40000 ALTER TABLE `verification` DISABLE KEYS */;
/*!40000 ALTER TABLE `verification` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-07-26 10:12:53
