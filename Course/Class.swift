//
//  Class.swift
//  Courses
//
//  Created by Weihang Zheng on 2022-07-18.
//
import Foundation

struct Class: Identifiable{
    var id = UUID()
    var teacher_name: String
    var area: String
    var subject: String
    var program: String
    
    init(raw: [String]){
        teacher_name = raw[0]
        area = raw[1]
        subject = raw[2]
        program = raw[3]
    }
}

struct Teacher_Des: Identifiable{
    var id = UUID()
    var teacher_name: String
    var description: String
    
    init(raw: [String]){
        teacher_name = raw[0]
        description = raw[1]
    }
}

func loadCSV(from csvName: String) -> [Class]{
    
    var csvToStruct = [Class]()
    
    guard let filePath = Bundle.main.path(forResource: csvName, ofType: "csv") else{
        return []
    }
    
    var data = ""
    do{
        data = try String(contentsOfFile: filePath)
    }catch{
        print(error)
        return []
    }
    var rows = data.components(separatedBy: "\n")
    rows.removeFirst()
    
    for row in rows{
        let csvColumns = row.description.components(separatedBy: ",")
        let teamStruct = Class.init(raw: csvColumns)
        csvToStruct.append(teamStruct)
    }
    
    return csvToStruct
}

func loadCSVTeacherDes(from csvName: String) -> [Teacher_Des]{
    
    var csvToStruct = [Teacher_Des]()
    
    guard let filePath = Bundle.main.path(forResource: csvName, ofType: "csv") else{
        return []
    }
    
    var data = ""
    do{
        data = try String(contentsOfFile: filePath)
    }catch{
        print(error)
        return []
    }
    var rows = data.components(separatedBy: "\n")
    rows.removeFirst()
    
    for row in rows{
        let csvColumns = row.description.components(separatedBy: ",")
        let teamStruct = Teacher_Des.init(raw: csvColumns)
        csvToStruct.append(teamStruct)
    }
    
    return csvToStruct
}

func getCourseTeachers() -> [String:[String]]{
    //let classes = loadCSV(from: "classes")
    var course_teachers: [String:[String]] = [:]
    /*
    for line in classes{
        course_teachers[line.subject, default: []].append(line.teacher_name)
    }*/
    course_teachers["History", default: []].append("Alina Liu")
    course_teachers["English", default: []].append("Alina Liu")
    
    course_teachers["Math", default: []].append("Edgar Ma")
    course_teachers["Physics", default: []].append("Edgar Ma")
    
    course_teachers["English", default: []].append("Fraser Carson")
    
    course_teachers["Math", default: []].append("Jack Jiao")
    
    course_teachers["French", default: []].append("Karen Liu")
    
    course_teachers["Math", default: []].append("Melissa Ma")
    course_teachers["Python", default: []].append("Melissa Ma")
    
    course_teachers["Biology", default: []].append("Serena Zhang")
    course_teachers["English", default: []].append("Serena Zhang")
    
    course_teachers["Chemistry", default: []].append("Siyi Zhang")
    
    course_teachers["CCC", default: []].append("Weihang Zheng")
    course_teachers["Python", default: []].append("Weihang Zheng")
    

    return course_teachers
}

func getAllTeachers() -> [String]{
    //let classes = loadCSV(from: "classes")
    var courseTeachers = getCourseTeachers()
    var teachers: Set<String> = []
    for (_, value) in courseTeachers{
        for teacher in value{
            teachers.insert(teacher)
        }
    }
    var teacher_list = [String]()
    for teacher in teachers{
        teacher_list.append(teacher)
    }
    teacher_list = teacher_list.sorted()
    
    return teacher_list
}

func getTeacherClasses() -> [String:[String]]{
    //let classes = loadCSV(from: "classes")
    var courseTeachers = getCourseTeachers()
    var teacher_classes: [String:[String]] = [:]
    for (key, value) in courseTeachers{
        for teacher in value{
            teacher_classes[teacher, default: []].append(key)
        }
    }
    return teacher_classes
}

func getAllCourses() -> [String]{
    //let classes = loadCSV(from: "classes")
    var courseTeachers = getCourseTeachers()
    var teacher_list = [String]()
    for (key, _) in courseTeachers{
        teacher_list.append(key)
    }
    teacher_list = teacher_list.sorted()
    
    return teacher_list
}

func getTeacherDes() -> [String:String]{
    var teacher_des: [String:String] = [:]
    teacher_des["Alina Liu"] = "以优异成绩毕业于多伦多顶级公立学校，在校期间屡次荣获全国各大商科类竞赛奖；目前就读西安大略大学毅伟商学院。辅导：雅思、9年级地理和10年级历史、OSSLT统考"
    teacher_des["Edgar Ma"] = "高中获得AP 五门满分，SAT 1550+；目前就读多伦多大学物理和数学专业。考进了AIME 美国数学竞赛。 辅导：9年级10年级数学、11和12物理, 数学竞赛."
    teacher_des["Fraser Carson"] = "英国文学硕士；精通学生心里沟通，负责教授新生作文的相关课程。有多年的丰富教学经验，辅导各年龄段的学生。能够帮助孩子们提高阅读理解能力、故事分析能力、论文写作能力，并建立基础语法和基础。辅导：雅思（着重写作和阅读部分）、阅读课、英美文学赏、安省各中学英语课"
    teacher_des["Jack Jiao"] = "高中以全校第一毕业，并获得总督奖；有长期和各年级学生沟通的经验，非常有耐心，受到学生的一致好评。目前就读多伦多大学工程系. 辅导：数学竞赛、AP 数学、11和12年级数学"
    teacher_des["Karen Liu"] = "从小在法语区长大，后又以IB法语满分毕业于多伦多以学术见长的IB公校，长年法语辅导经验. 辅导：法语、IB法语、AP法语"
    teacher_des["Melissa Ma"] = "高中以优异成绩毕业于多伦多以学术见长的IB公校，拥有多年丰富的教学经验，深受学生们爱戴。目前就读于多伦多大学工程系.辅导：11和12年级数学、物理、AP物理"
    teacher_des["Serena Zhang"] = "高中以优异成绩毕业于多伦多以学术见长的IB公校，拥有多年丰富的教学经验，深受学生们爱戴。目前就读于Guelph大学生命科学专业. 辅导：11和12年级生物、化学"
    teacher_des["Siyi Zhang"] = "拥有多年丰富的教学经验。目前就读于西安大略大学生命科学专业. 辅导：11和12年级生物、化学"
    teacher_des["Weihang Zheng"] = "UofT 计算机和AI工程， 计算机课 A+， Cerebras, Huawei, Splunk SWE 实习生. CCC 前百分之2， Leetcode Contest Rating 前百分之5. 有AI 出版物. 写了这个 APP. 辅导: 计算机和数学竞赛"
    return teacher_des
}

func getTeacherDesEng() -> [String:String]{
    var teacher_des: [String:String] = [:]
    teacher_des["Alina Liu"] = "Graduated with honors from Toronto's top public schools, and won several major national business competition awards during school; currently studying at the Ivey Business School of the University of Western Ontario. Tutoring: IELTS, Grade 9 Geography and Grade 10 History, OSSLT"
    teacher_des["Edgar Ma"] = "In high school, he got five full AP scores and SAT 1550+; he is currently studying Physics and Mathematics at the University of Toronto. Admitted to the AIME American Mathematics Competition. Tutoring: 9th grade 10th grade maths, 11th and 12th grade physics, math competitions."
    teacher_des["Fraser Carson"] = "Master of English Literature; proficient in students' inner communication, responsible for teaching freshmen's composition related courses. Has many years of rich teaching experience, tutoring students of all ages. It can help children improve their reading comprehension skills, story analysis skills, essay writing skills, and build basic grammar and foundation. Tutoring: IELTS (emphasis on writing and reading), reading classes, English and American literature awards, English classes in secondary schools in Ontario"
    teacher_des["Jack Jiao"] = "Graduated from high school with the first place in the school, and won the Governor's Award; has long-term experience in communicating with students of all grades, is very patient, and is well received by students. Currently studying Engineering at the University of Toronto. Tutoring: Math Contest, AP Math, 11th and 12th Grade Math"
    teacher_des["Karen Liu"] = "I grew up in the French-speaking area, and then graduated from an IB public school in Toronto with a full score of IB French. I have many years of experience in French tutoring. Tutoring: French, IB French, AP French"
    teacher_des["Melissa Ma"] = "Graduated from high school with honors from the IB public school in Toronto, which is good at academics. He has many years of rich teaching experience and is deeply loved by students. Currently studying in the Faculty of Engineering at the University of Toronto. Tutoring: 11th and 12th grade math, physics, AP physics"
    teacher_des["Serena Zhang"] = "Graduated from high school with honors from the IB public school in Toronto, which is good at academics. He has many years of rich teaching experience and is deeply loved by students. Currently studying Life Sciences at the University of Guelph. Tutoring: 11th and 12th grade Biology, Chemistry"
    teacher_des["Siyi Zhang"] = "Has many years of rich teaching experience. Currently studying at the University of Western Ontario majoring in life sciences. Tutoring: 11th and 12th grade biology, chemistry"
    teacher_des["Weihang Zheng"] = "UofT Computer and AI Engineering, Computer Class A+, Cerebras, Huawei, Splunk SWE Intern. Top 2% of CCC, Top 1% of Leetcode Contest Rating. Has AI publications. Wrote this APP. Tutor: Computer and Math competition"
    return teacher_des
}

func getSubjectDes() -> [String:String]{
    var teacher_des: [String:String] = [:]
    teacher_des["History"] = "本课程探讨从第一次世界大战到现在，那些塑造加拿大国家认同感的，地方，国家和全球的力量。学生将调查由经济，社会和技术变革带来的挑战，探索在此期间个人和团体对加拿大的文化和社会的贡献。学生将使用批判性思维和沟通技巧，去评估此期间问题和事件的不同解释，并提出自己的观点。"
    teacher_des["English"] = "本课程强调在学术和日常生活中取得成功所必需的文学、沟通以及批判性和创造性思维技能的发展。 学生学会分析来自不同时期、国家和文化的具有挑战性的文学，以及一系列信息和图形文本，并以各种形式创建书面和媒体内容。 其中重点是学会准确和清晰地使用语言，并适当有效地结合文体设备。 该课程帮助12年级英语必修课为大学课程做好准备。"
    teacher_des["Science"] = "G9 Science：加拿大安省SNC1D科学课程使学生能够发展他们对生物学、化学、地球和空间科学以及物理学的基本概念的理解，并将科学与技术、社会和环境联系起来。 在整个课程中，学生将在科学调查过程中发展他们的技能。 在本单元中，学生将学习定义和使用与物质分类相关的各种术语。G10 Science::本课旨在培养学生对科学类课程如生物、化学、物理甚至地球气候等的兴趣，提高他们的科学课程的掌握能力，了解物化生等学科的联系与区别，为以后的理科课程学习打好基础。"
    teacher_des["Math"] = "G9Math（教改后新内容）：9年级新数学课程内容。将强制要求学生学习编程，数据知识，数学建模，同时注重理财知识学习。 G10Math:线性关系的表达方式及其特征，解线性方程组，圆和线段，几何图行及性质，运用几何图形坐标解题，二次关系，二次关系的因式分解式，二次方程和指数方程的图像，因式分解代数表达式，二次关系的图像变换，二次关系的三种形式，解一元二次方程，解释一元二次方程的根，全等三角形和相似三角形，解相似三角形的问题，主要的三角函数比，解直角三角形，正弦定理，余弦定理. 11年级函数：MCR3U课程主要通过拓展学生对线性和二次关系的经验来介绍函数的数学概念。"
    teacher_des["Physics"] = "11年级物理 ：SPH3U物理一共有5个单元，学习的内容是相对来说比较基础的，但是涉及到的知识点是比较广泛的。 课程主要培养学生对对物理基本概念的理解。 学生将探索运动学，重点是直线运动;各种力;能量转换;机械波和声音的特性;以及电和磁。 还需要分析物理学与技术之间的相互关系，并考虑物理学的技术应用对社会和环境的影响。"
    teacher_des["French"] = "本课程为学生提供机会，使他们可以越来越独立地使用与日常生活相关且熟悉的话题以法语进行交流和互动。学生将用通利用过初级核心法语课程介绍的语言学习策略来继续发展语言知识和技能，并以各种方式运用创造性和批判性思维能力。他们还将增进对各种讲法语的社区的了解和欣赏，并培养终身学习语言必需的技能。"
    teacher_des["Python"] = "本课程教授您使用 Python 的基本编程概念。它旨在与 Python 或学校的类似课程一起学习。学生将了解什么是编码以及 Python 的应用。学生通过在屏幕上绘制形状并使用 Turtle Graphics 解决谜题来学习 Python 命令、函数和控制结构。学生通过编写通过键盘与用户交互的程序来学习编程基础知识。学生们教他们的程序根据收到的信息做出决策。学生学习如何使用循环作为快捷方式来编写更高效的代码。学生学习如何将他们的程序分解为更小的部分，这些部分共同解决问题。学生使用更复杂的策略来操作程序中的文本 - 切片、连接和格式化。学生学习元组和列表是如何形成的以及可以改变它们的各种方法。学生学习使用网格和字典构建更复杂的程序。"
    teacher_des["Biology"] = "11年级生物：SBI3U课程介绍 加拿大安省11年级生物（Biology）课程主要加深了学生对生物系统中发生的过程的理解。 课程主要学习在生物多样性领域学习理论和进行调查，进化，遗传过程，动物的结构和功能，以及植物的解剖、生长和功能。 本课程侧重于所研究主题的理论方面，并帮助学生完善与科学调查相关的技能。12年级生物：SBI4U课程是加拿大安大略省12年级生物课程，SBI4U课程为学生提供了深入研究生物系统中发生的概念和过程的机会。 学生将学习理论，并在生物化学、代谢过程、分子遗传学、体内平衡和种群动态等领域进行研究。"
    teacher_des["Chemistry"] = "11年级化学：课程使学生能够通过研究有机化学、物质的结构和性质、能量变化和反应速率、化学系统的平衡和电化学来加深对化学的理解。 学生进一步发展他们解决问题和调查的技能，并提高他们交流科学信息的能力。 重点将放在化学在日常生活中的重要性以及评估化学技术对环境的影响上。12年级化学：SCH4U课程是OSSD课程的化学科目，是加拿大安大略省十二年级的课程，SCH4U课程主要通过学习有机化学、物质的结构和性质、能量变化和反应速率、化学系统中的平衡以及电化学来加深学生对化学的理解。 在研究化学过程的同时，将进一步发展学什么解决问题和调查的技能，并将提高他们交流科学信息的能力。"
    teacher_des["CCC"] = "本课程为您准备加拿大计算机竞赛，您可以根据自己的水平参加初级或高级竞赛。复习所有基本算法概念并提供大量练习。"
    return teacher_des
}

func getSubjectDesEng() -> [String:String]{
    var teacher_des: [String:String] = [:]
    teacher_des["History"] = "This course examines the local, national and global forces that have shaped Canada's national identity from World War I to the present. Students will investigate the challenges posed by economic, social and technological change, exploring the contributions of individuals and groups to Canadian culture and society during this period. Students will use critical thinking and communication skills to evaluate alternative interpretations of issues and events during this period and to present their own perspectives."
    teacher_des["English"] = "This course emphasizes the development of literature, communication, and critical and creative thinking skills necessary for success in both academics and everyday life. Students learn to analyze challenging literature from different periods, countries and cultures, as well as a range of informational and graphic texts, and create written and media content in a variety of formats. Emphasis is placed on learning to use language accurately and clearly, with appropriate and effective combination of stylistic devices. The course prepares the compulsory Year 12 English course for university courses."

    teacher_des["Science"] = "G9 Science: Ontario, Canada The SNC1D Science curriculum enables students to develop their understanding of fundamental concepts in biology, chemistry, earth and space science, and physics, and to connect science to technology, society, and the environment. Throughout the course, students will develop their skills in the process of scientific inquiry. In this unit students will learn to define and use various terms in relation to the classification of substances. G10 Science:: This course aims to cultivate students' interest in science courses such as biology, chemistry, physics and even earth climate, improve their ability to master science courses, understand the connection and difference between physicochemical biology and other subjects, and prepare for future science courses Course study lays a solid foundation."
    teacher_des["Math"] = "G9Math (new content after teaching reform): 9th grade new mathematics curriculum content. It will be mandatory for students to learn programming, data knowledge, mathematical modeling, and at the same time focus on financial knowledge learning. G10Math: Expression and characteristics of linear relationships, solving linear equations, circles and line segments, geometric graphs and their properties, using geometric coordinates to solve problems, quadratic relationships, factorization of quadratic relationships, quadratic equations and Graphics of Exponential Equations, Factoring Algebraic Expressions, Graphical Transformations of Quadratic Relations, Three Forms of Quadratic Relations, Solving Quadratic Equations in One Unary, Explaining Roots of Quadratic Equations in One Unknown, Congruent and Similar Triangles, Solving Similarity Triangle problems, ratios of major trigonometric functions, solving right triangles, law of sines, law of cosines. Grade 11 Functions: The MCR3U course introduces the mathematical concept of functions primarily by extending students' experience with linear and quadratic relationships."
  
    teacher_des["Physics"] = "Grade 11 Physics: SPH3U Physics has a total of 5 units. The learning content is relatively basic, but the knowledge points involved are relatively extensive. The course focuses on developing students' understanding of the fundamental concepts of physics. Students will explore kinematics, with an emphasis on linear motion; various forces; energy transformation; properties of mechanical waves and sound; and electricity and magnetism. There is also a need to analyze the interrelationships between physics and technology, and to consider the social and environmental impacts of the technological applications of physics."
    teacher_des["French"] = "This course offers students the opportunity to communicate and interact in French with increasing independence, using familiar topics relevant to everyday life. Students will continue to develop language knowledge and skills through the use of language learning strategies introduced through the Junior Core French curriculum, and to use creative and critical thinking skills in a variety of ways. They will also develop an understanding and appreciation of the various French-speaking communities and develop the skills necessary for lifelong language learning."
    teacher_des["Python"] = "Students gain an understanding of what coding is and the applications of Python. Students learn Python commands, functions, and control structures by drawing shapes on their screen and solving puzzles with Turtle Graphics. Students learn the basics of programming by writing programs that interact with users through the keyboard. Students teach their programs to make decisions based on the information it receives. Students learn how to write more efficient code by using loops as shortcuts. Students learn how their programs can be decomposed into smaller pieces that work together to solve a problem. Students use more sophisticated strategies for manipulating text in their programs - slicing, concatenating, and formatting. Students learn how tuples and lists are formed and the various methods that can alter them. Students learn to build more complex programs that make use of grids and dictionaries."
    teacher_des["Biology"] = "Grade 11 Biology: Introduction to SBI3U Course The Grade 11 Biology course in Ontario, Canada mainly deepens students' understanding of the processes that occur in biological systems. The course focuses on studying theory and conducting investigations in the areas of biodiversity, evolution, genetic processes, animal structure and function, and plant anatomy, growth and function. This course focuses on the theoretical aspects of the topics studied and helps students refine skills related to scientific investigation. Grade 12 Biology: The SBI4U program is a Grade 12 biology program in Ontario, Canada, and the SBI4U program provides students with the opportunity to delve into the concepts and processes that occur in biological systems. Students will study theory and conduct research in areas such as biochemistry, metabolic processes, molecular genetics, homeostasis, and population dynamics."
    teacher_des["Chemistry"] = "Grade 11 Chemistry: The course enables students to develop an understanding of chemistry through the study of organic chemistry, the structure and properties of matter, energy changes and reaction rates, equilibrium of chemical systems, and electrochemistry. Students further develop their problem-solving and investigative skills and improve their ability to communicate scientific information. Emphasis will be placed on the importance of chemistry in everyday life and assessing the impact of chemical technologies on the environment. Grade 12 Chemistry: The SCH4U course is a chemistry subject of the OSSD course. It is a 12th grade course in Ontario, Canada. Chemistry to deepen students' understanding of chemistry. While studying chemical processes, problem-solving and investigative skills will be further developed and their ability to communicate scientific information will be enhanced."
    teacher_des["CCC"] = "This course prepares you for the Canadian Computing Competition, which you can enter as a beginner or advanced competition depending on your level. Reviews all basic algorithm concepts and provides plenty of practice."
    return teacher_des
}

