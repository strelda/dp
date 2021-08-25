// use rulinalg::matrix::Matrix;


// fn main() {
    

//     // println!("{:?}",eigen(3.0,8.2));
//     let matrix = Matrix::new(3,3, h(3.0,8.2));
        
//     let eig = vec!(matrix.eigenvalues());
    

//     //  assert_eq!(eig, vec![1.1, 1.123, 1.15, 2.0, 5.5]);
//     println!("{:?}",eig );

// }
// fn h(l: f64, x: f64) -> Vec<f64>{
//     return vec![x,0.5,0.5,
//             0.5,l+x,1.5,
//             0.5,1.5,1.0];
// }






// [dependencies]
// eigenvalues = "0.3.1"
// nalgebra = "0.25.3"
// vecstorage = "0.1.0"


// use nalgebra as na;

use eigenvalues::algorithms::lanczos::HermitianLanczos;
use eigenvalues::utils::{generate_random_sparse_symmetric};
use eigenvalues::SpectrumTarget;
// use na::{DMatrix};

fn main(){
    let mut matrix = generate_random_sparse_symmetric(3, 5, 3.0);
    // let m = na::DMatrix::from_row_slice(3,3,&[1.0, 2.0, 0.0,
    //                                       2.0, 2.0, 0.0,
    //                                       0.0, 0.0, 3.0]);
    
    for i in 1..9{
        matrix[i] = h(i as u32,1.0,2.0);
    }
    // println!("{:?}",matrix);
    
    let spectrum_target = SpectrumTarget::Lowest;
    let lanczos = HermitianLanczos::new(matrix.clone(), 20, spectrum_target).unwrap();
    println!("eig = {}",lanczos.eigenvalues.rows(0, 10));
    let eig2= lanczos.eigenvalues.rows(0, 2);
    println!("E1-E0 = {}", eig2[1]-eig2[0]);
}
fn h(i:u32, l: f64, x: f64) -> f64{
    let a = vec![x,0.5,0.5,
                    0.5,l+x,1.5,
                    0.5,1.5,1.0];
    a[i as usize]
}