/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package rashjz.info.com.az.controller;

import java.io.File;
import java.io.Serializable;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.swing.SortOrder;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import rashjz.info.com.az.AdminController.ProductControllerAdmin;
import static rashjz.info.com.az.controller.ProfileController.getExt;
import rashjz.info.com.az.domain.AppUser;
import rashjz.info.com.az.domain.PagingResult;
import rashjz.info.com.az.entity.Brand;
import rashjz.info.com.az.entity.Category;
import rashjz.info.com.az.entity.Gender;
import rashjz.info.com.az.entity.ProductImage;
import rashjz.info.com.az.entity.Products;
import rashjz.info.com.az.entity.Users;
import rashjz.info.com.az.service.BrandCategoryService;
import rashjz.info.com.az.service.CategoryService;
import rashjz.info.com.az.service.GenderCategoryServise;
import rashjz.info.com.az.service.ProductImagesService;
import rashjz.info.com.az.service.ProductService;
import rashjz.info.com.az.util.AuthoritiesConverter;
import rashjz.info.com.az.util.StaticParams;

/**
 *
 * @author Azik
 */
@Controller
public class UserController implements Serializable{
    
    private static final Logger logger = LoggerFactory.getLogger(UserController.class.getName());

    @Autowired
    ProductService productService;

    @Autowired
    ProductImagesService productImagesService;

    @Autowired
    private CategoryService categoryService;

    @Autowired
    private BrandCategoryService brandCategoryService;

    @Autowired
    private GenderCategoryServise genderCategoryServise;

    @ModelAttribute("categoryList")
    public List<Category> populateategoryList() {
        List<Category> list = categoryService.getAll(Category.class);
        return list;
    }

    @ModelAttribute("brandList")
    public List<Brand> populateBrandList() {
        List<Brand> list = brandCategoryService.getAll(Brand.class);
        return list;
    }

    @ModelAttribute("genderList")
    public List<Gender> populateLocList() {
        List<Gender> list = genderCategoryServise.getAll(Gender.class);
        return list;
    }
    
    @InitBinder
    protected void initBinder(WebDataBinder binder) {
        //  binder.setValidator(customerFormValidator);
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        dateFormat.setLenient(false);
        binder.registerCustomEditor(Date.class, new CustomDateEditor(dateFormat, true));
    }
    
//    Users users = AuthoritiesConverter.getUserObject().getUsers();
   
  @RequestMapping(value = "/productsuser", method = RequestMethod.GET)
    public String getProductsAll(Model model, @ModelAttribute("productsuser") Products products, Integer offset, Integer maxResults, BindingResult result) {
       System.out.println("---1");
        AppUser authUser = (AppUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
       System.out.println("---1");
       products.setInsertUser(authUser.getUsers());
       System.out.println("9999 ----------------------------------------  "+products.getInsertUser().getUsername() + " "+ products.getInsertUser().getUserId());
        Map<String, Object> filters = new HashMap<>();
//        products.setInsertUser(users);
        filters.put("", 0);
        if (result.hasErrors()) {
            System.out.println("xxxxx "+result.getFieldError().getDefaultMessage());
            return "login";
        }
        if (products == null) {
            products = new Products();
            products.setInsertUser(authUser.getUsers());
            filters.put("insertUser", products.getInsertUser());
        }
        PagingResult pagingData = new PagingResult();
        if (offset == null) {
            offset = 0;
            products.setInsertUser(authUser.getUsers());
            filters.put("insertUser", products.getInsertUser());
        }
       
        if (offset != null) {//new or old
//            filters.put("typeId", "1");       
            if (products.getTitle() != null && !products.getTitle().equals("")) {
                filters.put("title", products.getTitle());
            }
            if (products.getPrice() != null && !products.getPrice().equals("")) {
                filters.put("price", products.getPrice());
            }
            
            if (products.getCategoryId() != null && !products.getCategoryId().equals("") && products.getCategoryId().getCatId()!=0) {
                filters.put("categoryId", products.getCategoryId().getCatId());
            }
            if (products.getGenderId() != null && !products.getGenderId().equals("") && products.getGenderId().getGenderId()!=0) {
                filters.put("genderId", products.getGenderId().getGenderId());
            }
            if (products.getBrandId() != null && !products.getBrandId().equals("") && products.getBrandId().getId()!=0) {
                filters.put("brandId", products.getBrandId().getId());
            }
            if (products.getToDate() != null && !products.getToDate().equals("") ) {
                filters.put("toDate", products.getToDate());
            }
            if (products.getFromDate() != null && !products.getFromDate().equals("")) {
                filters.put("fromDate", products.getFromDate());
            }
            filters.put("insertUser", products.getInsertUser().getUserId());
        }
        
        pagingData = productService.lazyLoadProductsAdmin(offset.intValue(), 10, null, SortOrder.UNSORTED, filters);
        productService.lazyLoadProductsCountAdmin(offset.intValue(), 10, null, SortOrder.UNSORTED, filters, pagingData);
        model.addAttribute("productsList", pagingData.getList());
        model.addAttribute("count", pagingData.getTotalResult());
        model.addAttribute("productsuser", products);
        model.addAttribute("offset", offset);
        return "productUser";
    }

    @RequestMapping(value = "product/add", method = RequestMethod.GET)
    public String AddProductForm(Model model) {

        logger.debug("showAddProductForm()");

        Products product = new Products();
        model.addAttribute("product", product);
        return "editProduct";
    }

    @RequestMapping(value = "/editproduct", method = RequestMethod.POST)
    public String UpdateUser(@
            ModelAttribute("product") Products product,
            BindingResult result, Model model,
            final RedirectAttributes redirectAttributes) {
        logger.info("Update-User - - - " + product.toString());
        if (result.hasErrors()) {
            logger.info("Update-User- - - " + result.toString());
            return "403";
        } else {
            redirectAttributes.addFlashAttribute("css", "success");
            redirectAttributes.addFlashAttribute("msg", "Product updated successfully!");

            productService.update(product);

            return "redirect:/editproduct/" + product.getPId();
        }
    }

    @RequestMapping(value = "editproduct/{id}", method = RequestMethod.GET)
    public String EditUser(@PathVariable("id") int Id, Model model) {
        logger.debug("showProduct id: {}", Id);
        Products products = productService.getByKey(Id);
        model.addAttribute("product", products);
        return "editProduct";
    }

    @RequestMapping(value = "product/{id}/delete", method = RequestMethod.GET)
    public String getDelete(@PathVariable("id") Integer id,
            final RedirectAttributes redirectAttributes) {
        logger.info("deleteProduct() : {}" + id);
        Products products = productService.getByKey(id);
        productService.delete(products);
        redirectAttributes.addFlashAttribute("css", "success");
        redirectAttributes.addFlashAttribute("msg", "Product is deleted!");
        return "redirect:/productsadmin";

    }

    @RequestMapping(value = "productimg/{id}/{pid}/delete", method = RequestMethod.GET)
    public String productImageDelete(
            @PathVariable("id") Integer id,
            @PathVariable("pid") Integer pid,
            final RedirectAttributes redirectAttributes) {
        logger.info("productImageDelete() : {}" + id + " " + pid);
        ProductImage image = new ProductImage();
        image.setDetId(id);
        productImagesService.delete(image);
        redirectAttributes.addFlashAttribute("css", "success");
        redirectAttributes.addFlashAttribute("msg", "Product Image is deleted!");
        return "redirect:/editproduct/" + pid;
    }

    @RequestMapping(value = "/editproduct/uploadimagemulti", method = RequestMethod.POST)
    public String doUpload(HttpServletRequest request, HttpServletResponse response,
            @RequestParam("id") Integer id,
            @RequestParam("imagefile") List<MultipartFile> multipartFile) {
       
        for (MultipartFile file : multipartFile) {
            logger.info("--------------- " + "  file " + file.getOriginalFilename() + " id " + id);
            try {
                if (file != null && !file.isEmpty()) {
                    String fileName = UUID.randomUUID().toString() + "." + getExt(file.getOriginalFilename());
                    FileCopyUtils.copy(file.getBytes(), new File(StaticParams.UPLOAD_LOCATION + fileName));
                    //update userimage 
                    ProductImage image = new ProductImage();
                    Products p = new Products();
                    p.setPId(id);
                    image.setProductId(p);
                    //uploads -  url that will get image folder from mvc resources
                    image.setImgName("/uploads/" + fileName);
                    productImagesService.persist(image);
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return "redirect:/editproduct/" + id;
    }   
    
}