package com.solid.book;


import java.util.List;

public class BookReader implements IBookReader{
    public Book book;
    public static void main(String[] args) {
        BookReader bookReader = new BookReader();
       bookReader.printToScreen(bookReader.book);
    }

    @Override
    public void printToScreen(Book book) {
        do {
            System.out.println(book.getCurrentPage());
        } while (book.turnToNextPage());
        
    }
    BookReader(){
        this.book = new Book("Tyland", List.of("I", "moved", "here", "recently", "too"));
    }
}
