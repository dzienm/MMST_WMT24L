function R = rotation_matrix(axis, theta)
    % Ensure axis is a unit vector
    axis = axis / norm(axis);
    ux = axis(1);
    uy = axis(2);
    uz = axis(3);

    % Fundamental rotation generators
    sigma_x = [  0   0   0;
            0   0  -1;
            0   1   0 ];

    sigma_y = [  0   0   1;
            0   0   0;
           -1   0   0 ];

    sigma_z = [  0  -1   0;
            1   0   0;
            0   0   0 ];

    % Combined rotation generator
    K = ux * sigma_x + uy * sigma_y + uz * sigma_z;

    % Rotation matrix via matrix exponential
    R = expm(theta * K);  %expm not exp, exp is applied element-wise
end
