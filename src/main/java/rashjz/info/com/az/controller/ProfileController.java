/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package rashjz.info.com.az.controller;

import java.io.File;
import java.io.Serializable;
import java.security.Principal;
import java.util.AbstractList;
import java.util.ArrayList;
import java.util.Set;
import java.util.UUID;
import java.util.logging.Logger;
import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.social.connect.Connection;
import org.springframework.social.connect.ConnectionKey;
import org.springframework.social.connect.ConnectionRepository;
import org.springframework.social.facebook.api.Facebook;
import org.springframework.social.facebook.api.User;
import org.springframework.social.facebook.api.impl.FacebookTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import rashjz.info.com.az.domain.AppUser;
import rashjz.info.com.az.entity.UserRoles;
import rashjz.info.com.az.entity.Users;
import rashjz.info.com.az.service.UserService;
import rashjz.info.com.az.util.AuthoritiesConverter;
import rashjz.info.com.az.util.SecurityUtil;
import rashjz.info.com.az.util.StaticParams;

/**
 *
 * @author Rashad Javadov
 */
@Controller
public class ProfileController implements Serializable {

    private static final Logger logger = Logger.getLogger(ProfileController.class.getName());

    @Autowired
    UserService userService;

    @Inject
    private ConnectionRepository connectionRepository;

    @RequestMapping(value = "/profile", method = RequestMethod.GET)
    public String getProfilePage(Model model) {
        model.addAttribute("user", AuthoritiesConverter.getUserObject().getUsers());
        return "profile";
    }

    @RequestMapping(value = "/uploadimage", method = RequestMethod.POST)
    public String doUpload(
            HttpServletRequest request,
            HttpServletResponse response,
            @RequestParam("imagefile") MultipartFile file) { 
        try {
            if (file != null && !file.isEmpty()) {
                String fileName = UUID.randomUUID().toString() + "." + getExt(file.getOriginalFilename());
                FileCopyUtils.copy(file.getBytes(), new File(StaticParams.UPLOAD_LOCATION + fileName));
                //update userimage 
                Users users = AuthoritiesConverter.getUserObject().getUsers();
                //uploads -  url that will get image folder from mvc resources
                users.setImage("/uploads/" + fileName);
                userService.update(users); 
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "profile";
    }

    public static String getExt(String fileName) {
        String extension = "";
        int i = fileName.lastIndexOf('.');
        if (i > 0) {
            extension = fileName.substring(i + 1);
        }
        return extension;
    }

    @RequestMapping(value = "/connect/facebook", method = RequestMethod.GET)
    public String auth(Principal currentUser, Model model) {
        Connection<Facebook> connection = connectionRepository.findPrimaryConnection(Facebook.class);
        if (connection == null) {
            return "redirect:/connect/facebook";
        }
        ConnectionKey connectionKey = connection.getKey();
        Facebook facebook = connection.getApi();

        User user = facebook.userOperations().getUserProfile();
        Users users = userService.findByUsername(user.getEmail());

        if (users == null) {
            users = new Users();
            users.setEnabled(1);
            users.setFirstname(user.getFirstName());
            users.setLastname(user.getLastName());
            users.setPassword(user.getId());
//            users.setPhone(user.get());
            users.setImage("https://graph.facebook.com/" + user.getId() + "/picture");
            UserRoles roles = new UserRoles();
            roles.setUserId(users);
            roles.setUserRoleId(1);
            roles.setRole("ROLE_USER");
            userService.persist(users);
        }
        AppUser appUser = new AppUser(users, users.getUsername(), users.getPassword(), true, true, true, true, users.getUserRolesCollection());
        SecurityUtil.authenticateUser(appUser);
        return "redirect:/checkout";

    }
}
