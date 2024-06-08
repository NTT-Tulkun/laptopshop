package vn.hoidanit.laptopshop.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import vn.hoidanit.laptopshop.domain.User;

@Repository
public interface UserRepository extends JpaRepository<User, Long> {
    User save(User hoidanit); // save(): vừa lưu những thay đổi nếu đối tượng tồn tại rồi,
                              // tạo mới nếu chưa tồn tại

    List<User> findOneByEmail(String email); // List<User> là kiểu dữ liệu sẽ trả về

    User findById(long id);

    void deleteById(long id);

    boolean existsByEmail(String email);

    User findByEmail(String email);
}
