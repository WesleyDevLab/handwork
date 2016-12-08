/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package rashjz.info.com.az.AdminController;

import java.io.Serializable;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.swing.SortOrder;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import rashjz.info.com.az.domain.PagingResult;
import rashjz.info.com.az.entity.Brand;
import rashjz.info.com.az.entity.Category;
import rashjz.info.com.az.entity.Gender;
import rashjz.info.com.az.entity.OrderStatus;
import rashjz.info.com.az.entity.Products;
import rashjz.info.com.az.entity.Users;
import rashjz.info.com.az.service.BrandCategoryService;
import rashjz.info.com.az.service.CategoryService;
import rashjz.info.com.az.service.GenderCategoryServise;
import rashjz.info.com.az.service.ProductService;

/**
 *
 * @author Azik
 */
@Controller
@RequestMapping("/admin")
public class ProductControllerAdmin implements Serializable {

    private static final Logger logger = LoggerFactory.getLogger(ProductControllerAdmin.class.getName());

    @Autowired
    ProductService productService;

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
        SimpleDateFormat dateFormat = new SimpleDateFormat("dd-MM-yyyy HH:mm:ss.S");
        dateFormat.setLenient(false);
        binder.registerCustomEditor(Date.class, new CustomDateEditor(dateFormat, false));
    }

    @RequestMapping(value = "/products", method = RequestMethod.GET)
    public String getProductsAll(Model model, @ModelAttribute("products") Products products, Integer offset, Integer maxResults) {
        Map<String, Object> filters = new HashMap<>();
        filters.put("", 0);
        if (products == null) {
            products = new Products();
        }
        PagingResult pagingData = new PagingResult();
        if (offset == null) {
            offset = 0;

        }
        if (offset != null) {//new or old
//            filters.put("typeId", "1");
            if (products.getTitle() != null && !products.getTitle().equals("")) {
                filters.put("title", products.getTitle());
            }
            if (products.getPrice() != null && !products.getPrice().equals("")) {
                filters.put("price", products.getPrice());
            }
            if (products.getCategoryId() != null && !products.getCategoryId().equals("")) {
                filters.put("categoryId", products.getCategoryId());
            }
            if (products.getGenderId() != null && !products.getGenderId().equals("")) {
                filters.put("genderId", products.getGenderId());
            }
            if (products.getBrandId() != null && !products.getBrandId().equals("")) {
                filters.put("brandId", products.getBrandId());
            }
        }
        pagingData = productService.lazyLoadProductsAdmin(offset.intValue(), 10, null, SortOrder.UNSORTED, filters);
        productService.lazyLoadProductsCountAdmin(offset.intValue(), 10, null, SortOrder.UNSORTED, filters, pagingData);
        model.addAttribute("productsList", pagingData.getList());
        model.addAttribute("count", pagingData.getTotalResult());
        model.addAttribute("products", products);
        model.addAttribute("offset", offset);
        return "admin/productAdmin";
    }

    @RequestMapping(value = "/editproduct", method = RequestMethod.POST)
    public String UpdateUser(@ModelAttribute("product") Products product, BindingResult result, Model model, final RedirectAttributes redirectAttributes
    ) {
        logger.info("Update-User - - - " + product.toString());
        if (result.hasErrors()) {
            logger.info("Update-User- - - " + result.toString());
            return "403";
        } else {
            redirectAttributes.addFlashAttribute("css", "success");
            redirectAttributes.addFlashAttribute("msg", "Product updated successfully!");

            productService.update(product);

            return "redirect:/admin/editproduct/" + product.getPId();
        }
    }

    @RequestMapping(value = "editproduct/{id}", method = RequestMethod.GET)
    public String EditUser(@PathVariable("id") int Id, Model model
    ) {

        logger.debug("showProduct id: {}", Id);
        Products products = productService.getByKey(Id);

        System.out.println("showCustomers xxxxxxxxxxxxx" + products.toString());

        model.addAttribute("product", products);

        return "admin/editproduct";

    }

    @RequestMapping(value = "product/{id}/delete", method = RequestMethod.GET)
    public String getDelete(@PathVariable("id") Integer id,
            final RedirectAttributes redirectAttributes) {
        logger.info("deleteProduct() : {}" + id);
        Products products = productService.getByKey(id);
        productService.delete(products);
        redirectAttributes.addFlashAttribute("css", "success");
        redirectAttributes.addFlashAttribute("msg", "Product is deleted!");
        return "redirect:/admin/products";

    }
}
