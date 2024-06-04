import XCTest

final class ChantalUITests: XCTestCase {
    
    let app = XCUIApplication()
    
    
    override func setUpWithError() throws {
        
        // Запуск приложения
        app.launch()
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {
        
        // Завершение приложения
        app.terminate()
    }
    
    func openTaskCreation() -> ()  {
        app.navigationBars.buttons["Add"].tap()
        //открылся алерт для ввода задачи
        XCTAssert(app.alerts["Add Task"].exists)
    }
    
    func addNewTask(_ taskTitle: String) ->() {
        //Ввести название задачи
        app.alerts.textFields["Enter task name..."].tap()
        app.alerts.textFields["Enter task name..."].typeText(taskTitle)
        //Тап по кнопке добавления в алерте
        app.alerts.buttons["Add"].tap()
        
        
        //алерт ввода задачи закрылся
        XCTAssertFalse(app.alerts["Add Task"].exists)
        //введенная задача отображается в списке To-do
        XCTAssertTrue(app.cells.staticTexts[taskTitle].exists)
    }
    
    func moveTaskFromTodoToDone(_ taskTitle: String) ->() {
        //свайп задачи вправот(почему-то срабатывает только при двойном)
        app.cells.staticTexts[taskTitle].swipeRight()
        app.cells.staticTexts[taskTitle].swipeRight()
    
        //плохая проверка, что задача осталась после свайпа в Done, но не смогла построить путь с вхождением Done и названием Задачи
        XCTAssertTrue( app.cells.staticTexts[taskTitle].exists)
    }
    
    func makeTaskDeleted(_ taskTitle: String) ->() {
        //свайп задачи вправо (почему-то срабатывает только при двойном)
        app.cells.staticTexts[taskTitle].swipeLeft()
        app.cells.staticTexts[taskTitle].swipeLeft()
    
        //плохая проверка, что задачи нет
        XCTAssertFalse(app.cells.staticTexts[taskTitle].exists)
    }
    


    // ТК №1: “Добавление задачи в список”
    func testAddTaskToList() throws {
        //Подготовка данных
        let taskTitle = "Task 1"
        
        //1. Открытие формы создания задачи
        openTaskCreation()
        //2. Создание новой задачи
        addNewTask(taskTitle)
    }
    
    // ТК №2: “Отметка задачи как выполненной”
    func testMarkTaskCompleted() throws {
        //Подготовка данных
        let taskTitle = "Task 2"
        openTaskCreation()
        addNewTask(taskTitle)
        
        moveTaskFromTodoToDone(taskTitle)
    }
    
    // ТК №3: "Удаление запланированной задачи из списка”
    
    func testMarkTodoTaskDeleted() throws {
        //Подготовка данных
        let taskTitle = "Task 3"
        openTaskCreation()
        addNewTask(taskTitle)
        
        makeTaskDeleted(taskTitle)
    }
    
    // ТК №4: "Удаление выполненной задачи из списка”
    
    func testMarkDoneTaskDeleted() throws {
        //Подготовка данных
        let taskTitle = "Task 4"
        
        openTaskCreation()
        addNewTask(taskTitle)
        moveTaskFromTodoToDone(taskTitle)
                
        
        makeTaskDeleted(taskTitle)
    }
}
