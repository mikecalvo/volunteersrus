class AdminUser { 

    static constraints = {
        name(maxSize: 50)
        email(email: true, unique: true, maxSize: 30)
        password(maxSize: 8)
    }
    
    String email
    String password
    String name
    boolean superUser = false;

}