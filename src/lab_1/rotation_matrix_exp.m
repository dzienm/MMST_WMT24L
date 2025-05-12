function R = rotation_matrix_exp(u, theta)
% rotationMatrixFromGenerators computes a 3D rotation matrix using
% explicit rotation generators and matrix exponential
%   u: 3-element unit vector (axis of rotation)
%   theta: rotation angle in radians

    % Normalize the axis vector
    u = u / norm(u);
    ux = u(1);
    uy = u(2);
    uz = u(3);

    % Define rotation generators
    Gx = [0, 0, 0;
          0, 0, -1;
          0, 1, 0];

    Gy = [0, 0, 1;
          0, 0, 0;
         -1, 0, 0];

    Gz = [0, -1, 0;
          1,  0, 0;
          0,  0, 0];

    % Combine generators
    G = ux * Gx + uy * Gy + uz * Gz;

    % Compute matrix exponential
    R = expm(theta * G);
end
