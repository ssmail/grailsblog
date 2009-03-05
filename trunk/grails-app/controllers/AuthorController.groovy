import Author

class AuthorController {

    def scaffold = Author

    def about = {
        [author: Author.get(params?.id)]
    }

}
