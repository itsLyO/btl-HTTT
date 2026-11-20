package model;

import java.io.Serializable;

public class FullName6 implements Serializable {
    private static final long serialVersionUID = 1L;

    private int id;
    private String firstName;
    private String midName;
    private String lastName;

    public FullName6() {
    }

    public FullName6(int id, String firstName, String midName, String lastName) {
        this.id = id;
        this.firstName = firstName;
        this.midName = midName;
        this.lastName = lastName;
    }

    public FullName6(String firstName, String midName, String lastName) {
        this.firstName = firstName;
        this.midName = midName;
        this.lastName = lastName;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getFirstName() {
        return firstName;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public String getMidName() {
        return midName;
    }

    public void setMidName(String midName) {
        this.midName = midName;
    }

    public String getLastName() {
        return lastName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    public String getFullName() {
        StringBuilder sb = new StringBuilder();
        if (lastName != null && !lastName.trim().isEmpty()) {
            sb.append(lastName.trim());
        }
        if (midName != null && !midName.trim().isEmpty()) {
            if (sb.length() > 0) sb.append(" ");
            sb.append(midName.trim());
        }
        if (firstName != null && !firstName.trim().isEmpty()) {
            if (sb.length() > 0) sb.append(" ");
            sb.append(firstName.trim());
        }
        return sb.toString();
    }

    @Override
    public String toString() {
        return getFullName();
    }
}
