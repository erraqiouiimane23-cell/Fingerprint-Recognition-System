package model;

public class User {

    // ---- ATTRIBUTS ----
    private int    id;
    private String username;
    private String password;
    private String role;

    // ---- CONSTRUCTEUR VIDE ----
    public User() {}

    // ---- CONSTRUCTEUR COMPLET ----
    public User(int id, String username, String password, String role) {
        this.id       = id;
        this.username = username;
        this.password = password;
        this.role     = role;
    }

    // ---- GETTERS ----
    public int    getId()       { return id; }
    public String getUsername() { return username; }
    public String getPassword() { return password; }
    public String getRole()     { return role; }

    // ---- SETTERS ----
    public void setId(int id)          { this.id       = id; }
    public void setUsername(String u)  { this.username = u;  }
    public void setPassword(String p)  { this.password = p;  }
    public void setRole(String role)   { this.role     = role; }
}