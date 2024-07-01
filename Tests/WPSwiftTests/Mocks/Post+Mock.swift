//
//  Post+Mock.swift
//
//
//  Created by Ulaş Sancak on 6.10.2023.
//

import Foundation
@testable import WPSwift

extension Post {
    static var mockData: Data {
        get throws {
            guard let url = Bundle.module.url(forResource: "Post", withExtension: "json") else {
                throw MockError.fileNotFound("Post.json")
            }
            let data = try Data(contentsOf: url)
            return data
        }
    }
    static var mockFromData: Post {
        get throws {
            let data = try mockData
            let decoder = JSONDecoder.initialize()
            let post = try decoder.decode(Post.self, from: data)
            return post
        }
    }
    static var mock: Post {
        .init(
            id: 1234,
            date: DateFormatter.default.date(from: "2023-10-06T14:08:00"),
            modified: DateFormatter.default.date(from: "2023-10-06T14:08:00"),
            status: "publish",
            title: RenderedContent(rendered: "Lorem Ipsum is simply dummy text of the printing and typesetting industry."),
            content: RenderedContent(rendered: "<p> Malesuada porta eu velit urna ante venenatis mus cum, facilisis ipsum rutrum molestie. Euismod diam netus id varius, varius adipiscing phasellus nisl nam. Natoque tellus pulvinar faucibus primis. Imperdiet nascetur nullam aliquam ut mus torquent litora aptent libero? Elementum nostra, lorem tincidunt cursus! Dui tristique dignissim felis curae;. Dis praesent pellentesque varius pharetra aenean elementum non amet tincidunt. Porttitor urna aptent mattis odio scelerisque augue convallis fringilla. </p> <p> Rutrum conubia volutpat ad vulputate bibendum senectus magna molestie tincidunt placerat ultrices pulvinar. Vulputate semper sociis convallis eleifend et, ac aliquam sem massa diam. Metus at pharetra montes mi turpis arcu. Metus vestibulum feugiat massa sem aliquam odio blandit vivamus a lacinia nisi tellus. Urna venenatis sit ligula dis. In hac enim commodo vel euismod euismod. Quam condimentum vestibulum non orci. Lectus lacinia habitasse erat praesent. Nunc enim felis tempus hendrerit natoque viverra dui malesuada. Sapien dictum tortor nisl pulvinar, ut urna euismod velit. Ad convallis; rhoncus semper sapien urna. Vivamus magnis malesuada habitasse, platea platea. </p> <p> Condimentum nam iaculis congue habitasse tortor cursus blandit commodo. Vestibulum euismod egestas risus. Ultricies blandit mattis montes ipsum orci accumsan rutrum aenean. Cras sociis, nibh lacus morbi. Justo convallis convallis sem primis ad proin. Gravida magna convallis ultrices torquent nec. Fames maecenas natoque parturient. Natoque ipsum fusce et fames, morbi ipsum. Lacinia aenean facilisi nascetur sociosqu, vitae faucibus. Maecenas tincidunt varius neque fermentum. </p> <p> Magnis primis diam dui mauris dis habitant eleifend ligula at mollis. Nec parturient fermentum habitant torquent turpis laoreet dignissim nulla amet! Rhoncus nibh sapien lectus rhoncus. Suspendisse id hac conubia luctus diam nec curae;, proin tellus lacus ad est! Consequat proin mus erat duis leo a vivamus molestie massa. Varius, eros sit in pretium porttitor lacinia hendrerit habitasse vulputate? Nascetur potenti maecenas vestibulum nullam tellus lorem convallis augue ut. </p> <p> Torquent hac augue donec tristique. Feugiat netus iaculis faucibus. Dis ullamcorper egestas id dictumst. Parturient rhoncus pharetra maecenas. Curabitur ad velit curae; integer. Lorem sodales et commodo nascetur ornare sociosqu aenean ligula at vestibulum. Vestibulum nam purus mollis varius sit nec mauris. Auctor tellus consectetur non et bibendum diam cubilia erat! Aptent vestibulum pretium mattis. Justo ac, nec integer. Turpis sem netus sed mus penatibus tempus. Potenti erat accumsan tempus mattis risus senectus curae;! </p>"),
            excerpt: RenderedContent(rendered: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book."),
            author: 1,
            featured_media: 5678,
            comment_status: "open",
            categories: [1, 2],
            tags: [3, 4],
            embeddedContent: .mock
        )
    }
}

extension [Post] {
    static var mockData: Data {
        get throws {
            guard let url = Bundle.module.url(forResource: "Posts", withExtension: "json") else {
                throw MockError.fileNotFound("Posts.json")
            }
            let data = try Data(contentsOf: url)
            return data
        }
    }
    static var mockFromData: [Post] {
        get throws {
            let data = try mockData
            let decoder = JSONDecoder.initialize()
            let posts = try decoder.decode([Post].self, from: data)
            return posts
        }
    }
    static var mock: [Post] {
        [Post.mock]
    }
}

extension PostToCreate {
    static var mock: PostToCreate {
        .init(
            title: RenderedContent(rendered: "Lorem Ipsum is simply dummy text of the printing and typesetting industry."),
            content: RenderedContent(rendered: "<p> Malesuada porta eu velit urna ante venenatis mus cum, facilisis ipsum rutrum molestie. Euismod diam netus id varius, varius adipiscing phasellus nisl nam. Natoque tellus pulvinar faucibus primis. Imperdiet nascetur nullam aliquam ut mus torquent litora aptent libero? Elementum nostra, lorem tincidunt cursus! Dui tristique dignissim felis curae;. Dis praesent pellentesque varius pharetra aenean elementum non amet tincidunt. Porttitor urna aptent mattis odio scelerisque augue convallis fringilla. </p> <p> Rutrum conubia volutpat ad vulputate bibendum senectus magna molestie tincidunt placerat ultrices pulvinar. Vulputate semper sociis convallis eleifend et, ac aliquam sem massa diam. Metus at pharetra montes mi turpis arcu. Metus vestibulum feugiat massa sem aliquam odio blandit vivamus a lacinia nisi tellus. Urna venenatis sit ligula dis. In hac enim commodo vel euismod euismod. Quam condimentum vestibulum non orci. Lectus lacinia habitasse erat praesent. Nunc enim felis tempus hendrerit natoque viverra dui malesuada. Sapien dictum tortor nisl pulvinar, ut urna euismod velit. Ad convallis; rhoncus semper sapien urna. Vivamus magnis malesuada habitasse, platea platea. </p> <p> Condimentum nam iaculis congue habitasse tortor cursus blandit commodo. Vestibulum euismod egestas risus. Ultricies blandit mattis montes ipsum orci accumsan rutrum aenean. Cras sociis, nibh lacus morbi. Justo convallis convallis sem primis ad proin. Gravida magna convallis ultrices torquent nec. Fames maecenas natoque parturient. Natoque ipsum fusce et fames, morbi ipsum. Lacinia aenean facilisi nascetur sociosqu, vitae faucibus. Maecenas tincidunt varius neque fermentum. </p> <p> Magnis primis diam dui mauris dis habitant eleifend ligula at mollis. Nec parturient fermentum habitant torquent turpis laoreet dignissim nulla amet! Rhoncus nibh sapien lectus rhoncus. Suspendisse id hac conubia luctus diam nec curae;, proin tellus lacus ad est! Consequat proin mus erat duis leo a vivamus molestie massa. Varius, eros sit in pretium porttitor lacinia hendrerit habitasse vulputate? Nascetur potenti maecenas vestibulum nullam tellus lorem convallis augue ut. </p> <p> Torquent hac augue donec tristique. Feugiat netus iaculis faucibus. Dis ullamcorper egestas id dictumst. Parturient rhoncus pharetra maecenas. Curabitur ad velit curae; integer. Lorem sodales et commodo nascetur ornare sociosqu aenean ligula at vestibulum. Vestibulum nam purus mollis varius sit nec mauris. Auctor tellus consectetur non et bibendum diam cubilia erat! Aptent vestibulum pretium mattis. Justo ac, nec integer. Turpis sem netus sed mus penatibus tempus. Potenti erat accumsan tempus mattis risus senectus curae;! </p>"),
            format: "standard",
            sticky: false,
            excerpt: RenderedContent(rendered: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book."),
            status: "publish",
            password: "secretPassword",
            comment_status: "open",
            ping_status: "closed",
            categories: [10, 20],
            tags: [50, 60]
        )
    }
}

extension PostToUpdate {
    static var mock: PostToUpdate {
        .init(
            id: 1234,
            title: RenderedContent(rendered: "Lorem Ipsum is simply dummy text of the printing and typesetting industry."),
            content: RenderedContent(rendered: "<p> Malesuada porta eu velit urna ante venenatis mus cum, facilisis ipsum rutrum molestie. Euismod diam netus id varius, varius adipiscing phasellus nisl nam. Natoque tellus pulvinar faucibus primis. Imperdiet nascetur nullam aliquam ut mus torquent litora aptent libero? Elementum nostra, lorem tincidunt cursus! Dui tristique dignissim felis curae;. Dis praesent pellentesque varius pharetra aenean elementum non amet tincidunt. Porttitor urna aptent mattis odio scelerisque augue convallis fringilla. </p> <p> Rutrum conubia volutpat ad vulputate bibendum senectus magna molestie tincidunt placerat ultrices pulvinar. Vulputate semper sociis convallis eleifend et, ac aliquam sem massa diam. Metus at pharetra montes mi turpis arcu. Metus vestibulum feugiat massa sem aliquam odio blandit vivamus a lacinia nisi tellus. Urna venenatis sit ligula dis. In hac enim commodo vel euismod euismod. Quam condimentum vestibulum non orci. Lectus lacinia habitasse erat praesent. Nunc enim felis tempus hendrerit natoque viverra dui malesuada. Sapien dictum tortor nisl pulvinar, ut urna euismod velit. Ad convallis; rhoncus semper sapien urna. Vivamus magnis malesuada habitasse, platea platea. </p> <p> Condimentum nam iaculis congue habitasse tortor cursus blandit commodo. Vestibulum euismod egestas risus. Ultricies blandit mattis montes ipsum orci accumsan rutrum aenean. Cras sociis, nibh lacus morbi. Justo convallis convallis sem primis ad proin. Gravida magna convallis ultrices torquent nec. Fames maecenas natoque parturient. Natoque ipsum fusce et fames, morbi ipsum. Lacinia aenean facilisi nascetur sociosqu, vitae faucibus. Maecenas tincidunt varius neque fermentum. </p> <p> Magnis primis diam dui mauris dis habitant eleifend ligula at mollis. Nec parturient fermentum habitant torquent turpis laoreet dignissim nulla amet! Rhoncus nibh sapien lectus rhoncus. Suspendisse id hac conubia luctus diam nec curae;, proin tellus lacus ad est! Consequat proin mus erat duis leo a vivamus molestie massa. Varius, eros sit in pretium porttitor lacinia hendrerit habitasse vulputate? Nascetur potenti maecenas vestibulum nullam tellus lorem convallis augue ut. </p> <p> Torquent hac augue donec tristique. Feugiat netus iaculis faucibus. Dis ullamcorper egestas id dictumst. Parturient rhoncus pharetra maecenas. Curabitur ad velit curae; integer. Lorem sodales et commodo nascetur ornare sociosqu aenean ligula at vestibulum. Vestibulum nam purus mollis varius sit nec mauris. Auctor tellus consectetur non et bibendum diam cubilia erat! Aptent vestibulum pretium mattis. Justo ac, nec integer. Turpis sem netus sed mus penatibus tempus. Potenti erat accumsan tempus mattis risus senectus curae;! </p>"),
            format: "standard",
            sticky: false,
            excerpt: RenderedContent(rendered: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book."),
            status: "publish",
            password: "secretPassword",
            comment_status: "open",
            ping_status: "closed",
            categories: [12, 22],
            tags: [52, 62]
        )
    }
}
